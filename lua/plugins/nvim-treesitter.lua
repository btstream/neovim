return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = "User BufReadRealFile",
    event = "BufReadPre",
    dependencies = { "mrjones2014/nvim-ts-rainbow" },
    module = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            ignore_install = { "phpdoc" },
            highlight = { enable = true },
            rainbow = { enable = true },
        })
    end,
}
