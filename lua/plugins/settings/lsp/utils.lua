local local_config = require("nvim-dotnvim")
local lsp_status = require("lsp-status")

local M = {}

local attach_keys = function(client, bufnr)
    -- set keyboar for buffer
    local function buf_map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_map("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    buf_map("n", "gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
    buf_map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    -- buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    buf_map("n", "<leader>rn", '<cmd>lua require("cosmic-ui").rename()<cr>', opts)

    -- diagnostic
    buf_map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    buf_map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    buf_map("n", "ge", '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>', opts)
    buf_map("n", "<leader>ge", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

    -- hover
    buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    buf_map("n", "gs", "<cmd>lua require('lsp_signature').signature()<cr>", opts)

    -- code actions
    buf_map("n", "<C-k>.", "<cmd>lua require('cosmic-ui').code_actions()<cr>", opts)
    buf_map("v", "<C-k>.", "<cmd>lua require('cosmic-ui').range_code_actions()<cr>", opts)
    -- buf_map("n", "<C-k>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    -- buf_map("v", "<C-k>.", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", opts)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
    -- buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implematations<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
    -- buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    -- -- buf_set_keymap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    -- buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    -- buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- buf_set_keymap("n", "<C-k><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>d", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    -- -- setup code actions, for jdtls use jdtsls' codeaction
    -- -- buf_set_keymap('n', '<C-k>.', '<cmd>:Lspsaga code_action<cr>', opts)
    -- -- buf_set_keymap('i', '<C-k>.', '<Esc><cmd>:Lspsaga code_action<cr>', opts)
    -- buf_set_keymap("n", "<C-k>.", "<cmd>:Telescope lsp_code_actions<cr>", opts)
    -- buf_set_keymap("i", "<C-k>.", "<Esc><cmd>:Telescope lsp_code_actions<cr>", opts)
end

--- tools to return an function for on_init call back
--- @param server Server object of lsp config
--- @return function
M.on_init = function(server)
    return function(client)
        local local_settings = local_config.local_lsp_config(server.name)

        -- print(vim.json.encode(local_settings))

        -- local config has hightest priority
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, local_settings)

        vim.lsp.rpc.notify("workspace/didChangeConfiguration")
    end
end

--- helper function for lsp server's on_attach callback
--- @param client LspClient
--- @param bufnr number buffer handler
M.on_attach = function(client, bufnr)
    lsp_status.register_progress()
    lsp_status.on_attach(client, bufnr)
    attach_keys(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        hint_enable = false,
        hi_parameter = "IncSearch",
        handler_opts = {
            border = "single",
        },
    }, bufnr)

    -- save on formatting
    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup LspFormat
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
        augroup end
        ]])
    end
end

return M
