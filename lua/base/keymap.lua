local set = vim.keymap.set
local m = { "i", "n", "v" }

----------------------------------------------------------------------
--    disable Neovim's builtin LSP defaults (grn/gra/grr/gri/grt/grx)   --
----------------------------------------------------------------------
-- These are created unconditionally by runtime/lua/vim/_core/defaults.lua
-- and cannot be turned off with an option, so delete them here.
-- Their functionality is provided elsewhere:
--   grn  -> <leader>rn     gra -> <C-k>.
--   grr  -> gr (snacks)    gri -> gI (snacks)
--   grt  -> gy (snacks)    gO  -> <C-k>s (snacks)
-- NOTE: grx (codelens) has no replacement; add one if you ever need it.
for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx", "gO" }) do
    for _, mode in ipairs({ "n", "x" }) do
        pcall(vim.keymap.del, mode, lhs)
    end
end

set({ "n", "i" }, "<C-s>", require("utils.file").save_file, { desc = "Save file" })
if require("utils.os").name() == "macos" then
    set({ "n", "i" }, "<D-s>", require("utils.file").save_file, { desc = "Save file" })
end
set("i", "<S-Tab>", "<C-d>", { desc = "Decrease indent" })

set(m, "<C-n>", "<down>")
set(m, "<C-p>", "<up>")
set(m, "<C-f>", "<right>")
-- NOTE: <C-b> is intentionally left unmapped here; snacks maps it to the buffer
-- picker in n/i/v (see plugins/snacks/keys.lua) so the behaviour stays consistent.
set(m, "<C-a>", "<home>")
set(m, "<C-e>", "<end>")

-- clean search hilight
-- map("n", "<Esc><Esc>", "<cmd>nohl<cr>")

-- resize window
set("n", "<C-M-right>", "<cmd>vertical resize +1<cr>", { desc = "Widen window" })
set("n", "<C-M-left>", "<cmd>vertical resize -1<cr>", { desc = "Narrow window" })
set("n", "<C-M-up>", "<cmd>resize +1<cr>", { desc = "Increase height" })
set("n", "<C-M-down>", "<cmd>resize -1<cr>", { desc = "Decrease height" })

-- bufer
-- NOTE: `bn`/`bN`/`bc` were removed: a bare `b` would then wait for `timeoutlen`
-- before moving back a word. Use <A-,>/<A-.> (prev/next) and <A-w> (close) instead.
set("n", "<leader>q", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>bd", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>Q", require("utils.window").close_others, { desc = "close all other window" })

-- move lines
set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })
set("n", "<C-down>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
set("n", "<C-up>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })

set("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { silent = true, desc = "Move line down" })
set("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { silent = true, desc = "Move line up" })
set("i", "<C-down>", "<Esc><cmd>m .+1<CR>==gi", { silent = true, desc = "Move line down" })
set("i", "<C-up>", "<Esc><cmd>m .-2<CR>==gi", { silent = true, desc = "Move line up" })

set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
set("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
set("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

set("t", "<C-w>w", "<cmd>wincmd w<cr>", { desc = "Next window" })
set("t", "<C-w>h", "<cmd>wincmd h<cr>", { desc = "Window left" })
set("t", "<C-w>l", "<cmd>wincmd l<cr>", { desc = "Window right" })
set("t", "<C-w>j", "<cmd>wincmd j<cr>", { desc = "Window below" })
set("t", "<C-w>k", "<cmd>wincmd k<cr>", { desc = "Window above" })
