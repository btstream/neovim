local opt = vim.opt

----------------------------------------------------------------------
--                                ui                                --
----------------------------------------------------------------------
opt.cursorline = true
opt.signcolumn = "yes"
opt.number = true
opt.laststatus = 3
opt.fillchars = {
    -- winframes to use heavy separator
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    -- disable eob
    eob = " ",
    -- fold char
    fold = "┄",
}
opt.list = true
opt.listchars = {
    lead = "",
    space = "",
    tab = ">>",
}
opt.termguicolors = true

----------------------------------------------------------------------
--                              indent                              --
----------------------------------------------------------------------
opt.autoindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false

----------------------------------------------------------------------
--                              mouse                               --
----------------------------------------------------------------------
opt.mouse = opt.mouse + "a"

----------------------------------------------------------------------
--                            clipboard                             --
----------------------------------------------------------------------
opt.clipboard = "unnamedplus"

----------------------------------------------------------------------
--                           fileformats                            --
----------------------------------------------------------------------
opt.fileformats = "unix,dos"
opt.showmatch = true

----------------------------------------------------------------------
--                              spell                               --
----------------------------------------------------------------------
opt.spell = false

----------------------------------------------------------------------
--                           performance                            --
----------------------------------------------------------------------
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100

----------------------------------------------------------------------
--                               fold                               --
----------------------------------------------------------------------
function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local start_space = line:match("^   ")
    if start_space then
        line = line:sub(4)
    end
    return "┄┄" .. line .. ": " .. line_count .. " lines"
end
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevelstart = 99
opt.foldtext = "v:lua.custom_fold_text()"

----------------------------------------------------------------------
--                              search                              --
----------------------------------------------------------------------
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

----------------------------------------------------------------------
--                           Spell Check                            --
----------------------------------------------------------------------
vim.opt_local.spelloptions:append("noplainbuffer")
opt.spell = true

----------------------------------------------------------------------
--                            behavious                             --
----------------------------------------------------------------------
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

----------------------------------------------------------------------
--                               keys                               --
----------------------------------------------------------------------
-- set leader char to space
vim.g.mapleader = " "

----------------------------------------------------------------------
--                             Keymaps                              --
----------------------------------------------------------------------
local map = vim.keymap.set
local m = { "i", "n", "v" }

map("n", "<C-s>", "<cmd>w<cr>")
map("i", "<C-s>", "<cmd>w<cr><ESC>")
map("n", "<SPACEE>", "<Nop>")
map("i", "<S-Tab>", "<C-d>")
map("n", "<SPACEE>", "<Nop>")

map(m, "<C-n>", "<down>")
map(m, "<C-p>", "<up>")
map(m, "<C-f>", "<right>")
map(m, "<C-b>", "<left>")
map(m, "<C-a>", "<home>")
map(m, "<C-e>", "<end>")

-- clean search hilight
map("n", "<Esc><Esc>", "<cmd>nohl<cr>")

-- resize window
map("n", "<C-S-right>", "<cmd>vertical resize +1<cr>")
map("n", "<C-S-left>", "<cmd>vertical resize -1<cr>")
map("n", "<C-S-up>", "<cmd>resize +1<cr>")
map("n", "<C-S-down>", "<cmd>resize -1<cr>")

-- move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true })
map("n", "<C-down>", "<cmd>m .+1<CR>==", { silent = true })
map("n", "<C-up>", "<cmd>m .-2<CR>==", { silent = true })

map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })
map("i", "<C-down>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
map("i", "<C-up>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })

map("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { silent = true })
map("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
map("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv", { silent = true })
