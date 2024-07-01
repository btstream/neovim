return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = { { mode = { "n", "i" }, "<C-k>T", "<cmd>TodoTelescope<cr>", desc = "find todo labels" } },
    event = "User BufReadRealFilePost",
    config = function(_, opts)
        require("todo-comments").setup(vim.tbl_deep_extend("keep", opts, {}))
    end,
}
