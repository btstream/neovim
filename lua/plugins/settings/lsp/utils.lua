-- local lsp_status = require("lsp-status")

local null_ls_registered_fts = nil

local function set_desc(opts, desc)
    opts["desc"] = desc
end

local attach_keys = function(client, bufnr)
    local map = vim.keymap.set

    -- Mappings.
    local opts = { buffer = bufnr, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', set_desc(opts, "goto definitions"))
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", set_desc(opts, "goto declaration"))
    map(
        "n",
        "gi",
        '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
        set_desc(opts, "goto implementations")
    )
    map(
        "n",
        "gt",
        '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
        set_desc(opts, "goto type definitions")
    )
    map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', set_desc(opts, "get references"))
    -- buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", set_desc(opts, "rename"))

    -- diagnostic
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", set_desc(opts, "goto prev diagnostic"))
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", set_desc(opts, "goto next diagnostic"))
    map(
        "n",
        "ge",
        '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>',
        set_desc(opts, "get current line's diagnostic")
    )
    -- map(
    --     "n",
    --     "<leader>ge",
    --     "<cmd>Telescope diagnostics bufnr=0<cr>",
    --     set_desc(opts, "get diagnostics of current buffer")
    -- )
    map("n", "gE", "<cmd>Telescope diagnostics<cr>", set_desc(opts, "get diagnostics of workspace"))

    -- hover
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    -- map("n", "K", function()
    --     _G.lsp_show_hover = true
    --     vim.diagnostic.disable()
    --     vim.lsp.buf.hover()
    -- end, opts)

    -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --     buffer = bufnr,
    --     callback = function()
    --         _G.lsp_show_hover = false
    --         vim.diagnostic.enable()
    --     end,
    -- })

    -- code actions
    map("n", "<C-k>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", set_desc(opts, "code actions"))
    map("v", "<C-k>.", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", set_desc(opts, "code_action"))
end

local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormat", {})
--- helper function for lsp server's on_attach callback
--- @param client LspClient
--- @param bufnr number buffer handler
M.on_attach = function(client, bufnr)
    -- require("lsp-status").on_attach(client, bufnr)
    attach_keys(client, bufnr)

    if client.name == "null-ls" and null_ls_registered_fts == nil then
        null_ls_registered_fts = require("null-ls.sources").get_filetypes()
    end

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end -- save on formatting

    -- auto show diagnostics
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, {})
        end,
    })

    -- formatting before save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(client)
                        -- to check if null-ls has attached
                        -- local clients = vim.lsp.buf_get_clients(bufnr)
                        local ft = vim.fn.getbufvar(bufnr, "&filetype")
                        -- local has_null_ls = false
                        -- for _, c in pairs(clients) do
                        --     if c.name == "null-ls" then
                        --         has_null_ls = true
                        --     end
                        -- end

                        -- if there is no null ls or not configured to format this kind of files, then
                        -- use this client to format document
                        if null_ls_registered_fts == nil or not vim.tbl_contains(null_ls_registered_fts, ft) then
                            return true
                        elseif client.name == "null-ls" and vim.tbl_contains(null_ls_registered_fts, ft) then
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
