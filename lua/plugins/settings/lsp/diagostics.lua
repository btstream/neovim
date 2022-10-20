local signs = require("plugins.settings.lsp.ui").signs

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        border = "rounded",
        focusable = false,
        header = { "  Diagnostics:", "LspWinDiagnosticsTitle" },
        source = "always",
        winhighlight = "NormalFloat:LspWinDiagnosticsNormal,FloatBorder:LspWinDiagnosticsBorder",
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
            return " " .. i .. ". ", "LspDiagnosticsDefault" .. highlight
        end,
    },
    virtual_text = false,
})
