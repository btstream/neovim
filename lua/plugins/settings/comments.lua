local map = vim.api.nvim_set_keymap
require('Comment').setup()

map('i', '<C-k>/', '<Esc>:lua require("Comment").toggle()<cr><end>a', {noremap = true, silent = true})
map('n', '<C-k>/', ':lua require("Comment").toggle()<CR>', {noremap = true, silent = true})

