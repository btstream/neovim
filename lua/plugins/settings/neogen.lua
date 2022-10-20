local map = vim.keymap.set

require("neogen").setup({ enable = true })

map("n", "<Leader>nf", "<cmd>lua require('neogen').generate()<CR>")
map("n", "<Leader>nc", "<cmd>lua require('neogen').generate({type = 'class'})<CR>")
