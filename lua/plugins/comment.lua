return {
    "numToStr/Comment.nvim",
    -- keys = { "gcc", { mode = "v", "gc" } },
    keys = require("keymaps").comment.lazy_keys(),
    config = function()
        require("Comment").setup({
            ignore = "^$",
        })
    end,
}
