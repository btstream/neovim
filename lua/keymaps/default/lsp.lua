return {
    {
        "n",
        "gd",
        '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>',
        { desc = "goto definitions" },
    },
    { "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "goto declaration" } },
    {
        "n",
        "gi",
        '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>',
        { desc = "goto implementations" },
    },
    {
        "n",
        "gt",
        '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>',
        { desc = "goto type definitions" },
    },
    { "n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>', { desc = "get references" } },
    -- buf_{"n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts},
    { "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "rename" } },

    -- diagnostic
    { "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "goto prev diagnostic" } },
    { "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "goto next diagnostic" } },
    {
        "n",
        "ge",
        '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>',
        { desc = "get current line's diagnostic" },
    },
    { "n", "gE", "<cmd>Telescope diagnostics<cr>", { desc = "get diagnostics of workspace" } },

    -- hover
    { "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "open hover" } },
    -- code actions
    { "n", "<C-k>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "code actions" } },
    { "v", "<C-k>.", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", { desc = "code_action" } },
}
