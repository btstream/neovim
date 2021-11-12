vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
    a = { description = { '  Recently Opened Files          SPC f h' }, command = 'Telescope oldfiles' },
    b = { description = { '  Open Project                   SPC f p' }, command = 'Telescope projects' },
    c = { description = { '  Create New File                SPC c n' }, command = 'DashboardNewFile' },
    d = { description = { '  Find File                      SPC f f' }, command = 'Telescope find_files' },
    e = { description = { '  Find Word                      SPC f w' }, command = 'Telescope live_grep' },
    f = { description = { '  Choose Colorscheme             SPC t c' }, command = 'Telescope colorscheme' },
    g = { description = { '  Update Plugins                 SPC p u' }, command = 'PackerUpdate' },
    h = { description = { '  Configuration                  SPC s s' }, command = ':e ~/.config/nvim/init.lua' }
}

local mopt = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map('n', '<Leader>fh', ':DashboardFindHistory<CR>', mopt)
map('n', '<Leader>ff', ':DashboardFindFile<CR>', mopt)
map('n', '<Leader>tc', ':DashboardChangeColorscheme<CR>', mopt)
map('n', '<Leader>fw', ':DashboardFindWord<CR>', mopt)
map('n', '<Leader>fb', ':DashboardJumpMark<CR>', mopt)
map('n', '<Leader>cn', ':DashboardNewFile<CR>', mopt)
map('n', '<Leader>fp', ':Telescope projects<cr>', mopt)
map('n', '<Leader>pu', ':PackerUpdate<cr>', mopt)
map('n', '<Leader>ss', ':e ~/.config/nvim/init.lua<cr>', mopt)
