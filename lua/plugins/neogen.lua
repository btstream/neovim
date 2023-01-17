return {
    "danymat/neogen",
    config = function()
        require("plugins.settings.neogen")
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = { "<leader>nf", "<leader>nc" },
}
