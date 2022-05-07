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

lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.settings.lsp.utils").on_attach,
    capabilities = capabilities,
})

for _, server in pairs(lsp_installer.get_installed_servers()) do
    -- first to call server specified config
    if not pcall(require, "plugins.settings.lsp.providers." .. server.name) then
        lspconfig[server.name].setup({})
    end
end
