local map = vim.api.nvim_set_keymap

vim.g.nvim_tree_icons = { git = { unstaged = '', staged = '', untracked = '' } }

require'nvim-tree'.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = true,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = { enable = true, auto_open = true },
    diagnostics = { enable = false, icons = { hint = "", info = "", warning = "", error = "" } },
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },
    filters = { dotfiles = false, custom = {} },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'left',
        auto_resize = false,
        mappings = { custom_only = false, list = {} }
    }
}
map('n', '<C-k>b', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
map('i', '<C-k>b', '<Esc><cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.cmd([[
augroup nvim-tree-refresh
    au!
    autocmd BufReadPost * NvimTreeRefresh 
    autocmd BufEnter NvimTree NvimTreeRefresh 
augroup end
]])

