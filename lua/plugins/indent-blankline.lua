return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("plugins.settings.indent_line")
    end,
}
