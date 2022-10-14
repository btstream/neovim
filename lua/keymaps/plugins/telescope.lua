local map = vim.keymap.set
map({ "n", "i" }, "<C-k>p", "<cmd>Telescope find_files<cr>")

-- find symbols
map({ "n", "i" }, "<C-k>s", "<cmd>Telescope lsp_document_symbols<cr>")
map({ "n", "i" }, "<C-k><S-s>", "<cmd>Telescope lsp_workspace_symbols<cr>")

-- global find
map({ "n", "i" }, "<C-k>f", "<cmd>Telescope live_grep<cr>")

-- registers
map({ "n", "i" }, "<C-k>r", "<cmd>Telescope registers<cr>")

-- spell suggest
map("n", "z=", "<cmd>Telescope spell_suggest<cr>")

map({ "n", "i" }, "<C-k><C-o>", "<cmd>Telescope file_browser<cr>")
