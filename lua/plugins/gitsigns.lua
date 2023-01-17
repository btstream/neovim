return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User BufReadRealFile",
    config = function()
        require("plugins.settings.gitsigns")
    end,
}
