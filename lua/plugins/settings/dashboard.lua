vim.g.dashboard_default_executive = 'telescope'
local mopt = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

map('n', '<Leader>fh', ':DashboardFindHistory<CR>', mopt)
map('n', '<Leader>ff', ':DashboardFindFile<CR>', mopt)
map('n', '<Leader>tc', ':DashboardChangeColorscheme<CR>', mopt)
map('n', '<Leader>fa', ':DashboardFindWord<CR>', mopt)
map('n', '<Leader>fb', ':DashboardJumpMark<CR>', mopt)
map('n', '<Leader>cn', ':DashboardNewFile<CR>', mopt)
