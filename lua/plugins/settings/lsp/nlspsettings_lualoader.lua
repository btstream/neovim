local config = require("nlspsettings.config").get()
local schemas = require("nlspsettings.schemas").get_base_schemas_data()
local flatten = require("utils.flatten")

local function validate_config(server_name, settings)
    vim.validate({
        settings = { settings, "t" },
    })

    local error_key = {}

    -- flat table to vailida keys
    local schema_file = schemas[server_name]
    vim.notify(schema_file)
    if schema_file and vim.fn.filereadable(schema_file) == 1 then
        -- stylua: ignore
        local schema = vim.fn.system({
            "jq \'.properties\' " .. schema_file,
        })
        local max_depth = 0
        for key, _ in pairs(schema) do
            local len = #vim.split(key, "[.]")
            max_depth = max_depth < len and len or max_depth
        end
        settings = flatten(settings, max_depth)
        for key, _ in pairs(settings) do
            if not schema[key] then
                table.insert(error_key, key)
            end
        end
    end
    return error_key
end

local lsp_table_to_lua_table = function(t)
    vim.validate({
        t = { t, "t" },
    })

    local res = {}

    for key, value in pairs(t) do
        local key_list = {}

        for k in string.gmatch(key, "([^.]+)") do
            table.insert(key_list, k)
        end

        local tbl = res
        for i, k in ipairs(key_list) do
            if i == #key_list then
                tbl[k] = value
            end
            if tbl[k] == nil then
                tbl[k] = {}
            end
            tbl = tbl[k]
        end
    end

    return res
end

local function get_settings(root_dir, server_name)
    local local_settings_dir = config.local_settings_dir
    local global_settings_dir = config.config_home

    -- local settings
    local local_conf_file = vim.fn.expand(string.format("%s/%s/%s.lua", root_dir, local_settings_dir, server_name))
    local local_settings = vim.fn.filereadable(local_conf_file) == 1 and dofile(local_conf_file) or {}

    -- global settings
    local global_conf_file = vim.fn.expand(string.format("%s/%s.lua", global_settings_dir, server_name))
    local global_settings = vim.fn.filereadable(global_conf_file) == 1 and dofile(global_conf_file) or {}
    -- vim.notify(vim.json.encode(global_settings))

    -- validate
    local valid = true
    for _, v in pairs({ local_settings, global_settings }) do
        local error_keys = validate_config(server_name, v)
        if #error_keys ~= 0 then
            valid = false
            vim.notify(
                string.format(
                    "Config error on file %s: \n Server %s does not contain configurations of [%s]",
                    v,
                    server_name,
                    table.concat(error_keys, ",")
                )
            )
        end
    end

    local settings = {}
    if valid then
        settings = vim.tbl_deep_extend("keep", settings, local_settings)
        settings = vim.tbl.deep_extend("keep", settings, global_settings)
    end
    vim.notify(vim.json.encode(lsp_table_to_lua_table(settings)))
    return lsp_table_to_lua_table(settings)
end

return {
    get_settings = get_settings,
}
