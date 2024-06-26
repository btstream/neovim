-- local lsp_status = require("lsp-status")

local null_ls_registered_fts = nil

local M = {}

-- used to indicate lsp diagnostic float window id
local dia_win = nil

-- local namespace id, to avoid register key events more than one time
local ns_id = nil

local augroup = vim.api.nvim_create_augroup("LspFormat", {})
--- helper function for lsp server's on_attach callback
--- @param client lsp.Client
--- @param buf number buffer handler
M.on_attach = function(client, buf)
    -- require("lsp-status").on_attach(client, bufnr)
    -- attach_keys(client, bufnr)
    -- require("utils.keymap_tools").map(require("keymaps").lsp, bufnr)
    require("plugins.lsp.keymap")(buf)

    if client.name == "null-ls" and null_ls_registered_fts == nil then
        null_ls_registered_fts = require("null-ls.sources").get_filetypes()
    end

    -- if client.server_capabilities.documentSymbolProvider then
    --     require("nvim-navic").attach(client, bufnr)
    -- end -- save on formatting

    -- auto show diagnostics
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        buffer = buf,
        callback = function()
            _, dia_win = vim.diagnostic.open_float(nil, {
                focus = false,
                scope = "cursor",
                -- close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            })
        end,
    })

    -- to ensure regiester key event for only once
    if not ns_id then
        ns_id = vim.on_key(function(_)
            if dia_win and vim.tbl_contains(vim.api.nvim_list_wins(), dia_win) then
                vim.api.nvim_win_close(dia_win, true)
                dia_win = nil
            end
        end)
    end

    -- formatting before save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = buf,
                    filter = function(client)
                        if vim.g.autoformatting == false or vim.b.autoformatting == false then
                            return false
                        end
                        -- to check if null-ls has attached
                        -- local clients = vim.lsp.buf_get_clients(bufnr)
                        local ft = vim.fn.getbufvar(buf, "&filetype")
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

M.inlay_hint = function(buf, value)
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(ih) == "function" then
        ih(buf, value)
    elseif type(ih) == "table" and ih.enable then
        if value == nil then
            value = not ih.is_enabled(buf)
        end
        if not pcall(ih.enable, value, { bufnr = buf }) then
            ih.enable(buf, value)
        end
    end
end

return M
