local map = vim.api.nvim_set_keymap
require("Comment").setup()

local opts = { noremap = true, silent = true }
map("i", "<C-k>/", '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>a', opts)
map("n", "<C-k>/", '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', opts)
map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
