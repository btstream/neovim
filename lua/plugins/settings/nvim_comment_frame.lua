require("nvim-comment-frame").setup({
    keymap = "<leader>cc",
    multiline_keymap = "<leader>cC",
})

-- stylua: ignore start
vim.keymap.set("i", "<C-k>c", require("nvim-comment-frame").add_comment, {desc = "add single line comment frame"})
vim.keymap.set("i", "<C-k>C", require("nvim-comment-frame").add_multiline_comment, {desc = "add multiple line comment frame"})
-- stylua: ignore end
