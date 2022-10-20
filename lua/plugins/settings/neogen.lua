local map = vim.keymap.set

require("neogen").setup({ enable = true })

-- stylua: ignore start
map("n", "<Leader>nf", "<cmd>lua require('neogen').generate()<CR>", { desc = "generate docstr for function" })
map("n", "<Leader>nc", "<cmd>lua require('neogen').generate({type = 'class'})<CR>", { desc = "generate docstr for class" })
