return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("plugins.settings.terminal")
    end,
    keys = { "<C-k>t", "<C-k>g" },
}
