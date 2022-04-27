local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
require("sniprun").setup({ display = { "Classic" } })
map("n", "<F5>", "<cmd>%SnipRun<CR>", opts)
