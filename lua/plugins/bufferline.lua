return {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "User BufReadRealFile",
    config = function()
        require("plugins.settings.bufferline")
    end,
}
