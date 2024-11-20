local config = require("nlspsettings.config").get()
local schemas = require("nlspsettings.schemas").get_base_schemas_data()
local path = require("utils.os.path")
local flatten = require("utils.table").flatten
local deflatten = require("utils.table").deflatten
local require_file = require("utils.mods").require_file

local function validate_config(server_name, settings)
    -- vim.validate({
    --     settings = { settings, "t" },
    -- })

    local error_key = {}

    -- flat table to vailida keys
    local schema_file = vim.fn.expand(schemas[server_name])
    if schema_file and vim.fn.filereadable(schema_file) == 1 then
        local command = string.format("jq '.properties' %s", schema_file)
        local schema = vim.json.decode(vim.fn.system(command))
        local max_depth = 0
        for key, _ in pairs(schema) do
            local len = #vim.split(key, "[.]")
            max_depth = max_depth < len and len or max_depth
        end
        settings = flatten(settings, max_depth)
        for _, key in pairs(vim.tbl_keys(settings)) do
            if not schema[key] then
                table.insert(error_key, key)
            end
        end
    end
    return error_key
end

local M = {}
M.config_home = path.join(vim.fn.stdpath("config"), "lua", "plugins", "lsp", "servers-setting")

function M.get_settings(root_dir, server_name)
    local local_settings_dir = config.local_settings_dir
    local global_settings_dir = config.config_home

    -- local settings
    local local_conf_file = vim.fn.expand(string.format("%s/%s/%s.lua", root_dir, local_settings_dir, server_name))
    local local_settings = {}
    if vim.fn.filereadable(local_conf_file) == 1 then
        local_settings = require_file(local_conf_file)
    end
    -- local local_settings = vim.fn.filereadable(local_conf_file) == 1 and dofile(local_conf_file) or {}

    -- global settings
    local global_conf_file = vim.fn.expand(string.format("%s/%s.lua", global_settings_dir, server_name))
    local global_settings = {}
    if vim.fn.filereadable(global_conf_file) == 1 then
        global_settings = require_file(global_conf_file)
    end

    -- inner settings
    local inner_conf_file = vim.fn.expand(path.join(M.config_home, server_name .. ".lua"))
    local inner_settings = {}
    if vim.fn.filereadable(inner_conf_file) == 1 then
        inner_settings = require_file(inner_conf_file)
    end

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
        settings = vim.tbl_deep_extend("keep", settings, global_settings)
        settings = vim.tbl_deep_extend("keep", settings, inner_settings)
    end
    return deflatten(settings)
end

return M
