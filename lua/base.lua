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

map('i', '<C-n>', '<down>', mopt)
map('i', '<C-p>', '<up>', mopt)
map('i', '<C-f>', '<right>', mopt)
map('i', '<C-b>', '<left>', mopt)
map('i', '<C-a>', '<home>', mopt)
map('i', '<C-e>', '<end>', mopt)

map('n', '<C-n>', '<down>', mopt)
map('n', '<C-p>', '<up>', mopt)
map('n', '<C-f>', '<right>', mopt)
map('n', '<C-b>', '<left>', mopt)
map('n', '<C-a>', '<home>', mopt)
map('n', '<C-e>', '<end>', mopt)

map('v', '<C-n>', '<down>', mopt)
map('v', '<C-p>', '<up>', mopt)
map('v', '<C-f>', '<right>', mopt)
map('v', '<C-b>', '<left>', mopt)
map('v', '<C-a>', '<home>', mopt)
map('v', '<C-e>', '<end>', mopt)

