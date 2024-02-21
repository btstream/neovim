return {
    "nvim-lualine/lualine.nvim",
    event = "User LazyVimStarted",
    -- priority = 65535,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "linrongbin16/lsp-progress.nvim",
        -- "arkav/lualine-lsp-progress",
    },
    config = function()
        require("plugins.settings.lualine")
    end,
}
