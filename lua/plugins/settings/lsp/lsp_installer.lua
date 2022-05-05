local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend("keep", capabilities, require("lsp-status").capabilities)

-----------------------------------
-- setup lsp with lsp_installer
-----------------------------------
local servers = {
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
    -- "efm",
    "lemminx",
}
lsp_installer.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local on_init_callback = require("plugins.settings.lsp.utils").on_init(server)
    local on_attach_callback = require("plugins.settings.lsp.utils").on_attach

    -- call back functions to set keyboard
    local opts = { on_attach = on_attach_callback, on_init = on_init_callback }
    opts = vim.tbl_deep_extend("keep", opts, server:get_default_options())

    -- set up rust_analyzer
    if server.name == "rust_analyzer" then
        require("rust-tools").setup({
            server = opts,
            dap = require("plugins.settings.dap.rust"),
            tools = { autoSetHints = true },
        })
        return
    elseif server.name == "jdtls" then
        require("plugins.settings.lsp.providers.jdtls").setup(opts)
        return
    elseif server.name == "sumneko_lua" then
        -- add vim config to workspace library when on config dir
        opts.on_init = function(client)
            if vim.fn.getcwd() == vim.fn.stdpath("config") then
                local s = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    },
                }
                client.config.settings = vim.tbl_deep_extend("force", client.config.settings, s)
                vim.lsp.rpc.notify("workspace/didChangeConfiguration")
            else
                on_init_callback(client)
            end
        end
    end
    lspconfig[server.name].setup(opts)
end
