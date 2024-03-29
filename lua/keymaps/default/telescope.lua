return {
    { mode = { "n" }, "<Leader>fh", "<cmd>Telescope oldfiles<CR>", desc = "Open file history" },
    { mode = { "n" }, "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in cwd" },
    { mode = { "n" }, "<Leader>tc", "<cmd>Telescope colorscheme<CR>", desc = "Change colorscheme" },
    { mode = { "n" }, "<Leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find word in workspace" },
    { mode = { "n" }, "<Leader>cn", "<cmd>enew<CR>", desc = "Create new file" },
    { mode = { "n" }, "<Leader>fp", "<cmd>Telescope projects<cr>", desc = "Project history" },
    { mode = { "n" }, "<Leader>ss", "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua", desc = "Open Settings" },
    { mode = { "n", "i" }, "<C-k>p", "<cmd>Telescope find_files<cr>", desc = "find file" },
    { mode = { "n", "i" }, "<C-k>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "show document symboles" },
    {
        mode = { "n", "i" },
        "<C-k><S-s>",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        desc = "show workspace symboles",
    },
    { mode = { "n", "i" }, "<C-k>f", "<cmd>Telescope live_grep<cr>", desc = "find word in workspace" },
    { mode = { "n", "i" }, '<C-k>"', "<cmd>Telescope registers<cr>", desc = "look up registers" },
    { mode = { "n" }, "z=", "<cmd>Telescope spell_suggest<cr>", desc = "spell suggest" },
    { mode = { "n", "i" }, "<C-k><C-o>", "<cmd>Telescope file_browser<cr>", desc = "open file browser" },
    { mode = { "n", "i" }, "<C-b>", "<cmd>Telescope buffers<cr>", desc = "open buffers" },
    { mode = { "n", "i" }, "<C-k>r", "<cmd>Telescope resume<cr>", desc = "resume last Telescope session" },
}
