return {
    "s1n7ax/nvim-comment-frame",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-comment-frame").setup({
            keymap = "<leader>cc",
            multiline_keymap = "<leader>cC",
        })

        -- stylua: ignore start
        vim.keymap.set("i", "<C-k>c", require("nvim-comment-frame").add_comment, {desc = "add single line comment frame"})
        vim.keymap.set("i", "<C-k>C", require("nvim-comment-frame").add_multiline_comment, {desc = "add multiple line comment frame"})
        -- stylua: ignore end
        -- require("plugins.settings.nvim_comment_frame")
    end,
    keys = { "<leader>cC", "<leader>cc", { mode = "i", "<C-k>c" }, { mode = "i", "<C-k>C" } },
}
