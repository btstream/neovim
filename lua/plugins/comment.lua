return {
    "numToStr/Comment.nvim",
    config = function()
        require("plugins.settings.comments")
    end,
    keys = { "gcc", { mode = "v", "gc" } },
}
