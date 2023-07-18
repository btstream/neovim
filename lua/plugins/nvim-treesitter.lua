return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = "User BufReadRealFile",
    event = "BufReadPre",
    -- dependencies = { "mrjones2014/nvim-ts-rainbow" },
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    module = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            ignore_install = { "phpdoc" },
            highlight = { enable = true },
            -- rainbow = { enable = true },
        })
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup")({
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                commonlisp = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterYellow",
                "RainbowDelimiterGreen",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
                "RainbowDelimiterRed",
            },
            blacklist = { "c", "cpp" },
        })
    end,
}
