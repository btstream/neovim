return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "codecompanion", "Avante", "AvanteInput" },
    -- enabled = false,
    opts = {
        preview = {
            filetypes = { "markdown", "codecompanion", "Avante" },
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
