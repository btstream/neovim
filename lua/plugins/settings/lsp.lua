-- Setup lspconfig.
vim.lsp.set_log_level('debug')
-- local attach_keys = require('plugins.settings.lsp.utils').attach_keys

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend('keep', capabilities, require('lsp-status').capabilities)

-----------------------------------
-- setup lsp with lsp_installer
-----------------------------------
local lsp_installer = require("nvim-lsp-installer")
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
    "efm"
}
for _, name in pairs(servers) do
    local ok, server = lsp_installer.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

-- local function on_attach_callback(client, bufnr)
--     local lsp_status = require("lsp-status")
--     lsp_status.register_progress()
--     lsp_status.on_attach(client, bufnr)
--     attach_keys(client, bufnr)
--
--     -- save on formatting
--     if client.resolved_capabilities.document_formatting then
--         vim.cmd([[
--         augroup LspFormat
--             autocmd! * <buffer>
--             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
--         augroup end
--         ]])
--     end
-- end
--
lsp_installer.on_server_ready(function(server)

    local on_init_callback = require('plugins.settings.lsp.utils').on_init(server)
    local on_attach_callback = require('plugins.settings.lsp.utils').on_attach

    -- call back functions to set keyboard
    local opts = {
        cmd = server._default_options.cmd,
        capabilities = capabilities,
        on_attach = on_attach_callback,
        on_init = on_init_callback
    }

    -- set up rust_analyzer
    if server.name == 'rust_analyzer' then
        require('rust-tools').setup({ server = opts })
    elseif server.name == 'jdtls' then
        require("plugins.settings.lsp.jdtls").setup(opts)
        return
    elseif server.name == 'sumneko_lua' then
        -- add vim config to workspace library when on config dir
        opts.on_init = function(client)
            if vim.fn.getcwd() == vim.fn.stdpath('config') then
                local s = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } },
                        workspace = { library = vim.api.nvim_get_runtime_file('', true) }
                    }
                }
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, s)
                vim.lsp.rpc.notify('workspace/didChangeConfiguration')
            else
                on_init_callback(client)
            end
        end
    elseif server.name == 'efm' then
        opts = require("plugins.settings.lsp.efm")
        opts.cmd = server._default_options.cmd
        opts.on_attach = on_attach_callback
    end
    server:setup(opts)
end)

----------------------------------------
-- disable inline diagnostic info
----------------------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                                                                   { virtual_text = false, update_in_insert = true })

----------------------------------------
-- lspsaga
----------------------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga({ code_action_prompt = { enable = false } })

