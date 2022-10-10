local lsp_status = require("lsp-status")

local attach_keys = function(client, bufnr)
    local map = vim.keymap.set

    -- Mappings.
    local opts = { buffer = bufnr, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    map("n", "gi", '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', opts)
    map("n", "gt", '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', opts)
    map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', opts)
    -- buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    -- diagnostic
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    map("n", "ge", '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>', opts)
    map("n", "<leader>ge", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

    -- hover
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    map("n", "gs", "<cmd>lua require('lsp_signature').signature()<cr>", opts)

    -- code actions
    map("n", "<C-k>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    map("v", "<C-k>.", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", opts)
end

local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormat", {})
--- helper function for lsp server's on_attach callback
--- @param client LspClient
--- @param bufnr number buffer handler
M.on_attach = function(client, bufnr)
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

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end -- save on formatting

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(client)
                        -- to check if null-ls has attached
                        local clients = vim.lsp.buf_get_clients(bufnr)
                        local has_null_ls = false
                        for _, c in pairs(clients) do
                            if c.name == "null-ls" then
                                has_null_ls = true
                            end
                        end

                        if not has_null_ls then
                            return true
                        elseif client.name == "null-ls" then
                            return true
                        else
                            return false
                        end
                    end,
                })
            end,
        })
    end
end
return M
