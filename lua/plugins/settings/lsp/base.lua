local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")

local load_plugin = require("utils.packer").ensure_load
load_plugin("nlsp-settings.nvim")
load_plugin("lsp-status.nvim")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, require("lsp-status").capabilities)

local lsp_settings_path = vim.fn.stdpath("config") .. "/lsp-settings"

require("lsp-status").register_progress()
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
-- setup lsp with mason
-----------------------------------

-- config ensure installed lsp servers
local _servers = {
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
    "codelldb",
    "clangd",
}
local ensure_installed = {}
local lspconfig_to_packages = require("mason-lspconfig.mappings.server").lspconfig_to_package
for _, value in ipairs(_servers) do
    if lspconfig_to_packages[value] then
        table.insert(ensure_installed, lspconfig_to_packages[value])
    else
        table.insert(ensure_installed, value)
    end
end

require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = needed,
-- })
require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    auto_update = true,
})
require("mason-lspconfig").setup_handlers({
    function(server_name)
        if not pcall(require, "plugins.settings.lsp.providers." .. server_name) then
            lspconfig[server_name].setup({})
        end
    end,
})

-- a little trick for packer to load lspconfig lazily, which
-- is to call a BufRead autocmd to make current buffer attach
-- to lsp server
vim.schedule(function()
    vim.cmd("doautocmd BufRead")
end)
