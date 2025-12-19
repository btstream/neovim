-- local config = require("nlspsettings.config").get()
local lspconfig_utils = require("lspconfig.util")
local deflatten = require("utils.table").deflatten
local path = require("utils.os.path")
local require_file = require("utils.mods").require_file

local M = {}

local function load_local_server_configs(root_dir, server_name)
    local local_settings = {}
    if root_dir then
        local local_conf_file = vim.fn.expand(path.join(root_dir, ".nvim", "lsp", server_name .. ".lua"))
        if vim.fn.filereadable(local_conf_file) == 1 then
            local_settings = require_file(local_conf_file)
        end
    end
    local settings = {}
    settings = vim.tbl_deep_extend("keep", settings, local_settings)
    return deflatten(settings)
end

function M.common_settings()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
        on_attach = require("plugins.lsp.utils").on_attach,
        -- capabilities = capabilities,
        handlers = require("plugins.lsp.handlers"),
        single_file_support = true,
        offset_encoding = "utf-16",
        on_new_config = lspconfig_utils.add_hook_after(
            lspconfig_utils.default_config.on_new_config,
            function(new_config, root_dir)
                local name = new_config.name
                local config = load_local_server_configs(root_dir, name)
                new_config.single_file_support = true
                new_config = vim.tbl_deep_extend("keep", config, new_config)
            end
        ),
    })
    vim.lsp.config("*", lspconfig_utils.default_config)
end

return M
