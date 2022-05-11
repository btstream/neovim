require("nvim-comment-frame").setup({
    keymap = "<leader>cc",
    multiline_keymap = "<leader>cC",
})

vim.keymap.set("i", "<C-k>c", require("nvim-comment-frame").add_comment)
vim.keymap.set("i", "<C-k>C", require("nvim-comment-frame").add_multiline_comment)
