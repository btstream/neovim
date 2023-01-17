return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = { mode = { "n", "i" }, "<C-k>T" },
    config = function()
        require("plugins.settings.todo_comments")
    end,
}
