-- vim.g.rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
-- vim.g.rnvimr_enable_picker = 1
require('telescope').load_extension('file_browser')
vim.cmd([[nnoremap <silent> <C-k><C-o> :Telescope file_browser<CR>]])
