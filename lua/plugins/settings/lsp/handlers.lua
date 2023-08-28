return {

    ["textDocument/hover"] = function(_, result, ctx, _)
        local bufnr, _ = vim.lsp.handlers.hover(_, result, ctx, {
            border = "rounded",
            title = " 󰬋 Documentation ",
            title_pos = "center",
            source = "always",
            prefix = " ",
            scope = "cursor",
            winhighlight = "NormalFloat:LspWinHoverNormal,FloatBorder:LspWinHoverBorder",
            max_width = 120,
            stylize_markdown = true,
        })
        vim.api.nvim_set_option_value("filetype", "documentation", { buf = bufnr })
        vim.api.nvim_set_option_value("syntax", "markdown", { buf = bufnr })
    end,

    -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --     border = "rounded",
    --     winhighlight = "NormalFloat:LspWinSignatureNormal,FloatBorder:LspWinSignatureBorder",
    -- }),

    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false, update_in_insert = true }
    ),
}
