-- Setup lspconfig.
vim.lsp.set_log_level('debug')
local set_keys = function(client, bufnr)
    -- set keyboar for buffer
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


function LspSaveAction()
    -- vim.lsp.buf.formatting_sync()
    -- require('jdtls').organize_imports()
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities = vim.tbl_deep_extend('keep', capabilities, require('lsp-status').capabilities)
capabilities.textDocument = {
    completion = {
        completionItem = {
            snippetSupport = true
        }
    }
}

--setup lsp with lsp_installer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)

    -- call back functions to set keyboard

    local opts = {
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            local lsp_status = require("lsp-status")
            lsp_status.register_progress()
            -- require('jdtls')
            lsp_status.on_attach(client, bufnr)
            set_keys(client, bufnr)
        end
    }

    -- set up rust_analyzer
    if server.name == 'rust_analyzer' then
        -- print(vim.fn.json_encode(opt))
        -- opts.cmd = server._default_options.cmd
        require('rust-tools').setup({
            server = opts
        })
        server:attach_buffers()
    elseif server.name == 'jdtls' then
        JdtOpts = {
            cmd = server._default_options.cmd,
            on_attach = function(client, bufnr)
                require('lsp-status').on_attach(client, bufnr)
                set_keys(client, bufnr)
            end,
            settings = {
                ['java.saveActions.organizeImports'] = true
            }
        }
        vim.cmd([[
        augroup jdtls
            autocmd!
            autocmd FileType java lua require('jdtls').start_or_attach(JdtOpts)
        augroup end
        ]])
    else
        server:setup(opts)
    end
end)

