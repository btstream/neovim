return {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = { mode = { "n", "i" }, "<C-k>T" },
    config = function()
        require("todo-comments").setup({})
        vim.keymap.set({ "n", "i" }, "<C-k>T", "<cmd>TodoTelescope<cr>")
        -- require("plugins.settings.todo_comments")
    end,
}
