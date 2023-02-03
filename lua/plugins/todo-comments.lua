-- TODO:fix keymap
return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = { { mode = { "n", "i" }, "<C-k>T", "<cmd>TodoTelescope<cr>", desc = "find todo labels" } },
    event = "User BufReadRealFilePost",
    config = function()
        require("todo-comments").setup({})
    end,
}
