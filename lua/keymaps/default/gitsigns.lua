return {
    {
        "n",
        "]c",
        function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                package.loaded.gitsigns.next_hunk()
            end)
            return "<Ignore>"
        end,
        { expr = true },
    },

    {
        "n",
        "[c",
        function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                package.loaded.gitsigns.prev_hunk()
            end)
            return "<Ignore>"
        end,
        { expr = true },
    },
}
