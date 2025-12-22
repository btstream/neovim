local set = vim.keymap.set
local m = { "i", "n", "v" }

set({ "n", "i" }, "<C-s>", require("utils.file").save_file)
set("n", "<SPACEE>", "<Nop>")
set("i", "<S-Tab>", "<C-d>")
set("n", "<SPACEE>", "<Nop>")

set(m, "<C-n>", "<down>")
set(m, "<C-p>", "<up>")
set(m, "<C-f>", "<right>")
set(m, "<C-b>", "<left>")
set(m, "<C-a>", "<home>")
set(m, "<C-e>", "<end>")

-- clean search hilight
-- map("n", "<Esc><Esc>", "<cmd>nohl<cr>")

-- resize window
set("n", "<C-S-right>", "<cmd>vertical resize +1<cr>")
set("n", "<C-S-left>", "<cmd>vertical resize -1<cr>")
set("n", "<C-S-up>", "<cmd>resize +1<cr>")
set("n", "<C-S-down>", "<cmd>resize -1<cr>")

-- bufer
set("n", "bn", "<cmd>bnext<cr>", { desc = "goto next buffer" })
set("n", "bN", "<cmd>bprevious<cr>", { desc = "goto previous buffer" })
set("n", "bc", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>q", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>Q", require("utils.window").close_others, { desc = "close all other window" })

-- move lines
set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true })
set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true })
set("n", "<C-down>", "<cmd>m .+1<CR>==", { silent = true })
set("n", "<C-up>", "<cmd>m .-2<CR>==", { silent = true })

set("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
set("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })
set("i", "<C-down>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
set("i", "<C-up>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })

set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { silent = true })
set("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
set("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv", { silent = true })

set("t", "<C-w>w", "<cmd>wincmd w<cr>")
set("t", "<C-w>h", "<cmd>wincmd h<cr>")
set("t", "<C-w>i", "<cmd>wincmd i<cr>")
set("t", "<C-w>j", "<cmd>wincmd j<cr>")
set("t", "<C-w>k", "<cmd>wincmd k<cr>")
