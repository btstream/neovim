local opt = vim.opt
local map = vim.keymap.set

vim.g.mapleader = " "

-- use terminal color
opt.termguicolors = true
opt.number = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false
opt.autoread = true
-- mouse
opt.mouse = opt.mouse + "a"
opt.list = true
opt.cursorline = true
-- clipboard
-- opt.clipboard = opt.clipboard + "unnamedplus"
opt.clipboard = "unnamedplus"
-- fileformats
opt.fileformats = "unix,dos"
opt.showmatch = true
opt.spell = false
opt.autoindent = true
opt.signcolumn = "yes"
opt.exrc = true
opt.laststatus = 3
opt.splitright = true
opt.fillchars = "vert:┃"

-- auto commands to reload buffer
vim.cmd([[
augroup reladbuffer
    au!
    au CursorHold,CursorHoldI * checktime
    au FocusGained,BufEnter * :checktime
augroup end
]])

-----------------------------------------------------------
-- set keymaps
-----------------------------------------------------------
map("n", "<C-s>", "<cmd>w<cr>")
map("i", "<C-s>", "<cmd>w<cr><ESC>")
map("n", "<SPACEE>", "<Nop>")
map("i", "<S-Tab>", "<C-d>")
map("n", "<SPACEE>", "<Nop>")

local modes = { "i", "n", "v" }
for _, m in ipairs(modes) do
    map(m, "<C-n>", "<down>")
    map(m, "<C-p>", "<up>")
    map(m, "<C-f>", "<right>")
    map(m, "<C-b>", "<left>")
    map(m, "<C-a>", "<home>")
    map(m, "<C-e>", "<end>")
end

-- clean search hilight
map("n", "<Esc><Esc>", "<cmd>nohl<cr>")
map("n", "<C-S-right>", ":vertical resize +1<cr>")
map("n", "<C-S-left>", ":vertical resize -1<cr>")
map("n", "<C-S-up>", ":resize +1<cr>")
map("n", "<C-S-down>", ":resize -1<cr>")

vim.cmd([[
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

nnoremap <silent> <C-down> :m .+1<CR>==
nnoremap <silent> <C-up> :m .-2<CR>==
inoremap <silent> <C-down> <Esc>:m .+1<CR>==gi
inoremap <silent> <C-up> <Esc>:m .-2<CR>==gi
vnoremap <silent> <C-down> :m '>+1<CR>gv=gv
vnoremap <silent> <C-up> :m '<-2<CR>gv=gv
]])
