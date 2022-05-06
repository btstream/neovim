local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, require("lsp-status").capabilities)

require("nlspsettings").setup({
    config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
    local_settings_dir = ".nlsp-settings",
    local_settings_root_markers = { ".git" },
    append_default_schemas = true,
    loader = "json",
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
-- for _, server in pairs(

-- for _, server in pairs(lsp_installer.get_installed_servers()) do
--     server:on_ready(function(server)
--         local on_init_callback = require("plugins.settings.lsp.utils").on_init(server)
--         local on_attach_callback = require("plugins.settings.lsp.utils").on_attach
--
--         -- call back functions to set keyboard
--         local opts = { on_attach = on_attach_callback, on_init = on_init_callback }
--         opts = vim.tbl_deep_extend("keep", opts, server:get_default_options())
--
--         -- set up rust_analyzer
--         if server.name == "rust_analyzer" then
--             require("rust-tools").setup({
--                 server = opts,
--                 dap = require("plugins.settings.dap.rust"),
--                 tools = { autoSetHints = true },
--             })
--             return
--         elseif server.name == "jdtls" then
--             require("plugins.settings.lsp.providers.jdtls").setup(opts)
--             return
--         elseif server.name == "sumneko_lua" then
--             -- add vim config to workspace library when on config dir
--             opts.on_init = function(client)
--                 local s = {
--                     Lua = {
--                         format = {
--                             enable = false,
--                         },
--                     },
--                 }
--                 if vim.fn.getcwd() == vim.fn.stdpath("config") then
--                     s.Lua["diagnostics"] = { globals = { "vim" } }
--                     s.Lua["workspace"] = { library = vim.api.nvim_get_runtime_file("", true) }
--                     client.config.settings = vim.tbl_deep_extend("force", client.config.settings, s)
--                     vim.lsp.rpc.notify("workspace/didChangeConfiguration")
--                 else
--                     client.config.settings = vim.tbl_deep_extend("force", client.config.settings, s)
--                     on_init_callback(client)
--                 end
--             end
--         end
--         lspconfig[server.name].setup(opts)
--     end)
-- end
