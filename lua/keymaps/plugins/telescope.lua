local map = vim.keymap.set
map({ "n", "i" }, "<C-k>p", "<cmd>Telescope find_files<cr>", { desc = "find file" })

-- find symbols
map({ "n", "i" }, "<C-k>s", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "document symboles" })
map({ "n", "i" }, "<C-k><S-s>", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "workspace symboles" })

-- global find
map({ "n", "i" }, "<C-k>f", "<cmd>Telescope live_grep<cr>", { desc = "find word in workspace" })

-- registers
map({ "n", "i" }, "<C-k>r", "<cmd>Telescope registers<cr>", { desc = "look up registers" })

-- spell suggest
map("n", "z=", "<cmd>Telescope spell_suggest<cr>", { desc = "spell suggest" })

map({ "n", "i" }, "<C-k><C-o>", "<cmd>Telescope file_browser<cr>", { desc = "open file browser" })
