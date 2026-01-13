return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "AgenticChat" },
    -- enabled = false,
    opts = {
        preview = {
            filetypes = { "markdown", "AgenticChat" },
            ignore_buftypes = {},
            modes = { "n", "no", "c", "i" },
            hybrid_modes = { "i" },
            linewise_hybrid_mode = true
            -- hybrid_modes = { "i" }
        },
        markdown = {
            horizontal_rules = {
                enable = false
            }
        }
    },
}
