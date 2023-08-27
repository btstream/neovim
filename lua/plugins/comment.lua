return {
    "numToStr/Comment.nvim",
    -- keys = require("keymaps").comment.lazy_keys(),
    event = { "User BufReadRealFile" },
    config = function()
        require("Comment").setup({
            ignore = "^$",
        })
    end,
}
