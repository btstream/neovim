local map = vim.keymap.set
require("sniprun").setup({ display = { "Classic" } })
map("n", "<F5>", "<cmd>%SnipRun<CR>")
