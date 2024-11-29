return {
    settings = {
        ["rust-analyzer"] = {
            imports = {
                prefix = "self",
                granularity = {
                    group = "module",
                },
            },
            completion = {
                autoimport = { enable = true },
            },
        },
    },
    -- server = require("nvim-lsp-installer.servers.rust_analyzer"):get_default_options(),
    -- dap = require("plugins.settings.dap.rust"),
    tools = { autoSetHints = false },
}
