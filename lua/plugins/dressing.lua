return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
        require("plugins.settings.dressing")
    end,
}
