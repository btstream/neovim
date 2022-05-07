local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, require("lsp-status").capabilities)

local lsp_settings_path = vim.fn.stdpath("config") .. "/lsp-settings"

-----------------------------------
-- setup nlspsettings to load
-- json config
-----------------------------------
require("nlspsettings").setup({
    config_home = lsp_settings_path,
    local_settings_dir = ".nvim",
    local_settings_root_markers = { ".git", ".nvim" },
    append_default_schemas = true,
    loader = "json",
})

-----------------------------------
-- setup to load global and local
-- lua config
-----------------------------------
-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
--     on_new_config = lspconfig_utils.add_hook_before(
--         lspconfig.util.default_config.on_new_config,
--         function(new_config, root_dir)
--             vim.notify(new_config.name)
--         end
--     ),
-- })
-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {})

-----------------------------------
-- setup lsp with lsp_installer
-----------------------------------
local needed = {
    "bashls",
    "pyright",
    "jdtls",
    "rust_analyzer",
    "jsonls",
    "cssls",
    "html",
    "vuels",
    "vimls",
    "sumneko_lua",
    "fortls",
    "lemminx",
}

lsp_installer.setup({
    ensure_installed = needed,
})

local on_new_config = lspconfig_utils.default_config.on_new_config
vim.notify(type(on_new_config))

lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.settings.lsp.utils").on_attach,
    capabilities = capabilities,
    on_new_config = lspconfig_utils.add_hook_before(on_new_config, function(new_config, root_dir)
        local name = new_config.name
        new_config.settings = vim.tbl_deep_extend(
            "keep",
            require("plugins.settings.lsp.nlspsettings_lualoader").get_settings(root_dir, name),
            new_config.settings
        )
    end),
})

for _, server in pairs(lsp_installer.get_installed_servers()) do
    vim.notify(server.name)
    -- first to call server specified config
    if not pcall(require, "plugins.settings.lsp.providers." .. server.name) then
        lspconfig[server.name].setup({})
    end
end
