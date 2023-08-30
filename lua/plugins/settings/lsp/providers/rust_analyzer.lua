require("rust-tools").setup({
    -- server = require("nvim-lsp-installer.servers.rust_analyzer"):get_default_options(),
    -- dap = require("plugins.settings.dap.rust"),
    tools = { autoSetHints = false },
})
-- require("lspconfig").rust_analyzer.setup({})
