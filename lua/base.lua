local opt = vim.opt

-------------------------
-- ui
-------------------------
opt.cursorline = true
opt.signcolumn = "yes"
opt.number = true
opt.laststatus = 3
opt.fillchars = {
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    eob = " ",
}
opt.list = true
opt.listchars = {
    lead = "⋅",
    tab = ">>",
}
opt.termguicolors = true

-------------------------
-- indent
-------------------------
opt.autoindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false

-------------------------
-- mouse
-------------------------
opt.mouse = opt.mouse + "a"

-------------------------
-- clipboard
-------------------------
opt.clipboard = "unnamedplus"

-------------------------
-- fileformats
-------------------------
opt.fileformats = "unix,dos"
opt.showmatch = true

-------------------------
-- spell
-------------------------
opt.spell = false

-------------------------
--performance
-------------------------
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100

-------------------------
--search
-------------------------
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-------------------------
-- behavious
-------------------------
opt.splitright = true
opt.autoread = true
-- auto commands to reload buffer
vim.cmd([[
augroup reladbuffer
    au!
    au CursorHold,CursorHoldI * checktime
    au FocusGained,BufEnter * :checktime
augroup end
]])

-----------------------------------------------------------
-- keys
-----------------------------------------------------------
-- set leader char to space
vim.g.mapleader = " "
local map = vim.keymap.set

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
map("n", "<C-S-right>", "<cmd>vertical resize +1<cr>")
map("n", "<C-S-left>", "<cmd>vertical resize -1<cr>")
map("n", "<C-S-up>", "<cmd>resize +1<cr>")
map("n", "<C-S-down>", "<cmd>resize -1<cr>")

vim.cmd([[
nnoremap <silent> <A-j> <cmd>m .+1<CR>==
nnoremap <silent> <A-k> <cmd>m .-2<CR>==
inoremap <silent> <A-j> <Esc><cmd>m .+1<CR>==gi
inoremap <silent> <A-k> <Esc><cmd>m .-2<CR>==gi
vnoremap <silent> <A-j> <cmd>m '>+1<CR>gv=gv
vnoremap <silent> <A-k> <cmd>m '<-2<CR>gv=gv

nnoremap <silent> <C-down> <cmd>m .+1<CR>==
nnoremap <silent> <C-up> <cmd>m .-2<CR>==
inoremap <silent> <C-down> <Esc><cmd>m .+1<CR>==gi
inoremap <silent> <C-up> <Esc><cmd>m .-2<CR>==gi
vnoremap <silent> <C-down> <cmd>m '>+1<CR>gv=gv
vnoremap <silent> <C-up> <cmd>m '<-2<CR>gv=gv
]])
