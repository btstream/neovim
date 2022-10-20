local map = vim.keymap.set
map({ "n", "i" }, "<C-k>b", "<cmd>NvimTreeToggle<CR>", { desc = "open nvimtree" })
