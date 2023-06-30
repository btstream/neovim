return {

    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        -- focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        source = "always",
        prefix = " ",
        scope = "cursor",
        winhighlight = "NormalFloat:LspWinHoverNormal,FloatBorder:LspWinHoverBorder",
        max_width = 120,
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
