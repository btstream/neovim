-- local local_config = require("nvim-dotnvim")
local lsp_status = require("lsp-status")
local cosmic_ui = require("cosmic-ui")

local function rename()
    cosmic_ui.rename({
        win_options = {
            winhighlight = "NormalFloat:LspFloatWinNormal",
        },
    })
end

local attach_keys = function(client, bufnr)
    local buf_map = vim.keymap.set

    -- Mappings.
    local opts = { buffer = bufnr, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_map("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    buf_map("n", "gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
    buf_map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    -- buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    buf_map("n", "<leader>rn", rename, opts)

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
end

local M = {}
--- tools to return an function for on_init call back
--- @param server Server object of lsp config
--- @return function
-- M.on_init = function(server)
--     local name = type(server) == table and server.name or server
--     return function(client)
--         local local_settings = local_config.local_lsp_config(name)
--         client.config.settings = vim.tbl_deep_extend("force", client.config.settings, local_settings)
--         -- vim.lsp.rpc.notify("workspace/didChangeConfiguration")
--         client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
--     end
-- end

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
