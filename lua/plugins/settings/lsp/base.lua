-- local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, require("lsp-status").capabilities)

local lsp_settings_path = vim.fn.stdpath("config") .. "/lsp-settings"

require("plugins.settings.lsp.ui").setup()
-----------------------------------
-- setup nlspsettings to load
-- json and lua config for settings
-----------------------------------
require("nlspsettings").setup({
    config_home = lsp_settings_path,
    local_settings_dir = ".nvim",
    local_settings_root_markers = { ".git", ".nvim" },
    append_default_schemas = true,
    loader = "json",
})

-- lua config
lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.settings.lsp.utils").on_attach,
    capabilities = capabilities,
    handlers = require("plugins.settings.lsp.handlers"),
    -- add_hook_after, has a much more priority than nlspsettings.nvim
    on_new_config = lspconfig_utils.add_hook_after(
        lspconfig_utils.default_config.on_new_config,
        function(new_config, root_dir)
            local name = new_config.name
            new_config.settings = vim.tbl_deep_extend(
                "keep",
                require("plugins.settings.lsp.nlspsettings_lualoader").get_settings(root_dir, name),
                new_config.settings
            )
        end
    ),
})

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

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = needed,
})
require("mason-lspconfig").setup_handlers({
    function(server_name)
        if not pcall(require, "plugins.settings.lsp.providers." .. server_name) then
            lspconfig[server_name].setup({})
        end
    end,
})
