local signs = require("plugins.lsp.ui").signs

local config = {
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        border = "rounded",
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        header = "",
        title = " 󰩂 Diagnostics ",
        source = "always",
        max_width = 180,
        winhighlight =
        "NormalFloat:LspWinDiagnosticsNormal,FloatBorder:LspWinDiagnosticsBorder,FloatTitle:LspWinDiagnosticsTitle",
        prefix = function(d, i, _)
            local highlight = "Normal"
            if d.severity == vim.diagnostic.severity.ERROR then
                highlight = "Error"
            elseif d.severity == vim.diagnostic.severity.HINT then
                highlight = "Hint"
            elseif d.severity == vim.diagnostic.severity.WARN then
                highlight = "Warning"
            elseif d.severity == vim.diagnostic.severity.INFO then
                highlight = "Information"
            end
            return "" .. i .. ". ", "LspDiagnosticsDefault" .. highlight
        end,
        suffix = function(d, _, _)
            local highlight = "Normal"
            if d.severity == vim.diagnostic.severity.ERROR then
                highlight = "Error"
            elseif d.severity == vim.diagnostic.severity.HINT then
                highlight = "Hint"
            elseif d.severity == vim.diagnostic.severity.WARN then
                highlight = "Warning"
            elseif d.severity == vim.diagnostic.severity.INFO then
                highlight = "Information"
            end
            return d.code == nil and "" or " [" .. d.code .. "] ", "LspDiagnosticsDefault" .. highlight
        end,
    },
    virtual_text = false,
}

-- if vim.fn.has("nvim-0.9") == 1 then
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- end

if vim.fn.has("nvim-0.10") == 1 then
    config.signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    }
end

vim.diagnostic.config(config)
