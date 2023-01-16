----------------------------------------------------------------------
--                       Config basic key map                       --
----------------------------------------------------------------------

local map = vim.keymap.set
local m = { "i", "n", "v" }

map({ "n", "i" }, "<C-s>", function()
    if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "readonly") then
        vim.cmd("SudaWrite")
    else
        vim.cmd("write")
        vim.cmd("stopinsert")
    end
end)

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
