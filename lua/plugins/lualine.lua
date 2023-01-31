return {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    -- priority = 65535,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
    },
    config = function()
        require("plugins.settings.lualine")
    end,
}
