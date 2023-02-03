return {
    "numToStr/Comment.nvim",
    keys = { "gcc", { mode = "v", "gc" } },
    config = function()
        require("Comment").setup({
            ignore = "^$",
        })
    end,
}
