return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        "folke/snacks.nvim",
    },
    enabled = function()
        return vim.fn.executable("opencode") == 1
    end,
    keys = {
        {
            mode = { "n", "x" },
            "<C-k>aa",
            function() require("opencode").ask("@this: ", { submit = true }) end,
            desc = "Ask opencode…"
        },
        {
            mode = { "n", "x" },
            "<C-k>ax",
            function() require("opencode").select() end,
            desc = "Execute opencode action…"
        },
        { mode = { "n", "t" }, "<C-|>", function() require("opencode").toggle() end, desc = "Toggle opencode" },
    },
    config = function()
        vim.o.autoread = true
        vim.keymap.set({ "n", "x" }, "<C-k>a=", function() return require("opencode").operator("@this ") end,
            { desc = "Add range to opencode", expr = true })
        vim.keymap.set("n", "<C-k>a-", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Add line to opencode", expr = true })
    end,
}
