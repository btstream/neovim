return {
    "numToStr/Comment.nvim",
    -- keys = require("keymaps").comment.lazy_keys(),
    event = { "User BufReadRealFile" },
    opts = {
        ignore = "^$",
    },
    -- config = function()
    --     require("Comment").setup()
    -- end,
}
