require("Comment").setup({
    ignore = "^$",
})

local map = vim.keymap.set

map("i", "<C-_>", '<cmd>lua require("Comment.api").toggle_current_linewise()<CR><ESC>$a')
map("n", "<C-_>", '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>')
map("n", "<Leader>nf", "<cmd>lua require('neogen').generate()<CR>")
