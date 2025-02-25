local set = vim.keymap.set
return function(buf)
    -- set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "goto declaration", buffer = buf })
    -- set("n", "gd", "<cmd>Glance definitions<cr>", { desc = "goto definitions", buffer = buf })
    -- set("n", "gi", "<cmd>Glance implementations<cr>", { desc = "goto implementations", buffer = buf })
    -- set("n", "gt", "<cmd>Glance type_definitions<cr>", { desc = "goto type definitions", buffer = buf })
    -- set("n", "gr", "<cmd>Glance references<cr>", { desc = "get references", buffer = buf })

    -- buf_{"n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts},
    set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "rename", buffer = buf })

    -- diagnostic
    set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "goto prev diagnostic", buffer = buf })
    set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "goto next diagnostic", buffer = buf })
    -- set(
    --     "n",
    --     "ge",
    --     '<cmd>lua vim.diagnostic.open_float(nil, { scope = "line", })<cr>',
    --     { desc = "get current line's diagnostic", buffer = buf }
    -- )
    -- set("n", "gE", "<cmd>Telescope diagnostics<cr>", { desc = "get diagnostics of workspace", buffer = buf })

    -- hover
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "open hover", buffer = buf })
    -- code actions
    set("n", "<C-k>.", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "code actions", buffer = buf })
    set("v", "<C-k>.", "<cmd>lua vim.lsp.buf.range_code_actions()<cr>", { desc = "code_action", buffer = buf })
end
