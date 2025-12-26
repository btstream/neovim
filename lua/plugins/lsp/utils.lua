-- local lsp_status = require("lsp-status")
local M = {}

-- used to indicate lsp diagnostic float window id
local dia_win = nil

-- local namespace id, to avoid register key events more than one time
local ns_id = nil

local augroup = vim.api.nvim_create_augroup("LspFormat", {})

-- to check if filetype is configured to format this filetype
local function check_efm_formatter(filetype)
    local configured_ft = vim.lsp.config["efm"].settings.languages[filetype]
    if configured_ft then
        for _, c in pairs(configured_ft) do
            return c.formatCommand ~= nil
        end
    end
    return false
end

--- helper function for lsp server's on_attach callback
M.on_attach = function(client, buf)
    -- require("lsp-status").on_attach(client, bufnr)
    -- attach_keys(client, bufnr)
    -- require("utils.keymap_tools").map(require("keymaps").lsp, bufnr)
    require("plugins.lsp.keymap")(buf)

    -- auto show diagnostics
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        buffer = buf,
        callback = function()
            vim.diagnostic.open_float()
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
    if client:supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = buf,
                    filter = function(c)
                        if vim.g.autoformatting == false or vim.b.autoformatting == false then
                            return false
                        end
                        local ft = vim.fn.getbufvar(buf, "&filetype")

                        -- if this file is configured with efm
                        if check_efm_formatter(ft) then
                            if c.name == "efm" then
                                return true
                            else
                                return false
                            end
                        else
                            if c.name == "efm" then
                                return false
                            else
                                return true
                            end
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
