return {
    "numToStr/Comment.nvim",
    -- keys = require("keymaps").comment.lazy_keys(),
    event = { "User BufReadRealFile" },
    opts = {
        ignore = "^$",
    },
    enabled = function()
        return false
        -- return vim.fn.has("nvim-0.10") ~= 1
    end,
}
