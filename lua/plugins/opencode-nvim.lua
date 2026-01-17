return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        "folke/snacks.nvim",
    },
    keys = {
        {
            mode = { "n", "x" },
            "<C-a>",
            function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask opencode…" }
        },
        {
            mode = { "n", "x" },
            "<C-x>",
            function() require("opencode").select() end,
            { desc = "Execute opencode action…" }
        },
        { mode = { "n", "t" }, "<C-\\>", function() require("opencode").toggle() end, { desc = "Toggle opencode" } },
        {
            mode = { "n", "x" },
            "go",
            function() return require("opencode").operator("@this ") end,
            { desc = "Add range to opencode", expr = true }
        },
        { "n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Add line to opencode", expr = true } },
    },
    config = function()
        vim.o.autoread = true
    end,
}
