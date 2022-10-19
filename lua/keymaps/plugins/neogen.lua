local map = vim.keymap.set

map("n", "<leader>nc", "<cmd>lua require('neogen').generate({type='class'})<cr>")
map("n", "<leader>nf", "<cmd>lua require('neogen').generate()<cr>")
