local opt = vim.opt
local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

-- use terminal color
opt.termguicolors = true
opt.number = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false
opt.mouse = opt.mouse + "a"
opt.list = true
opt.cursorline = true
opt.clipboard = opt.clipboard + "unnamedplus"

local mopt = {noremap = true, silent = true}
map('n', '<C-s>', '<cmd>w<CR>', mopt)
map('i', '<C-s>', '<ESC><cmd>w<CR>', mopt)
map('n', '<SPACEE>', '<Nop>', mopt)
map('i', '<S-Tab>', '<C-d>', mopt)

local modes = {'i', 'n', 'v'}
for _, m in ipairs(modes) do
    map(m, '<C-n>', '<down>', mopt)
    map(m, '<C-p>', '<up>', mopt)
    map(m, '<C-f>', '<right>', mopt)
    map(m, '<C-b>', '<left>', mopt)
    map(m, '<C-a>', '<home>', mopt)
    map(m, '<C-e>', '<end>', mopt)
end
