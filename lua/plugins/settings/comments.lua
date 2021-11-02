local map = vim.api.nvim_set_keymap
require('Comment').setup()

map('i', '<A-/>', '<Esc>:lua require("Comment").toggle()<CR>', {noremap = true, silent = true})
