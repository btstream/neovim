require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = { enable = true },
    rainbow = { enable = true }
})
vim.wo.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false
