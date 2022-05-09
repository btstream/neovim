return {

    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        winhighlight = "NormalFloat:LspWinHoverNormal,FloatBorder:LspWinHoverBorder",
    }),

    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        winhighlight = "NormalFloat:LspWinSignatureNormal,FloatBorder:LspWinSignatureBorder",
    }),

    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false, update_in_insert = true }
    ),
}
