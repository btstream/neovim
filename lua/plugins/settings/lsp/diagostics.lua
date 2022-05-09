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
        border = "solid",
        focusable = false,
        header = { " Diagnostics:", "LspWinDiagnosticsNormal" },
        source = "always",
        winhighlight = "NormalFloat:LspWinDiagnosticsNormal,FloatBorder:LspWinDiagnosticsBorder",
    },
    virtual_text = false,
})
