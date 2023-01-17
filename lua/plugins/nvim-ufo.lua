return {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "User BufReadRealFile",
    config = function()
        require("plugins.settings.ufo")
    end,
}
