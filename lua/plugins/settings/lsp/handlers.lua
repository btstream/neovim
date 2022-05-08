vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    winhighlight = "NormalFloat:LspNormalFloat,FloatBorder:LspFloatBorder",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    winhighlight = "NormalFloat:LspNormalFloat,FloatBorder:LspFloatBorder",
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = false, update_in_insert = true }
)
