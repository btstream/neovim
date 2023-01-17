return {
    "Vonr/align.nvim",
    event = "User BufReadRealFile",
    config = function()
        require("plugins.settings.align")
    end,
}
