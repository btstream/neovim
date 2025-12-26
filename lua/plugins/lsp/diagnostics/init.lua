local signs = require("themes.icons").lsp_diagnostic_signs

local config = {
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
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
require("plugins.lsp.diagnostics.popup")
