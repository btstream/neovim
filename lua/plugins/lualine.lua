return {
    "nvim-lualine/lualine.nvim",
    event = "User LazyDone",
    -- priority = 65535,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "arkav/lualine-lsp-progress",
    },
    config = function()
        require("plugins.settings.lualine")
    end,
}
