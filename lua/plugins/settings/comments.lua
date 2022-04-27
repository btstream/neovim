local map = vim.api.nvim_set_keymap
require("Comment").setup()

local opts = { noremap = true, silent = true }
map("i", "<C-k>/", '<Esc>:lua require("Comment").toggle()<cr><end>a', opts)
map("n", "<C-k>/", ':lua require("Comment").toggle()<CR>', opts)
map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
