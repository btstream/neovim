return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "User BufReadRealFile",
    dependencies = { "mrjones2014/nvim-ts-rainbow" },
    config = function()
        require("plugins.settings.treesitter")
    end,
}
