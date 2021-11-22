require('nvim-treesitter.configs').setup({ ensure_installed = 'maintained', highlight = { enable = true } })
vim.wo.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false
