return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
        {
            "ahmedkhalf/project.nvim",
            event = "User BufReadRealFile",
            config = function()
                require("plugins.settings.project")
            end,
        },
    },
    cmd = "Telescope",
    config = function()
        require("plugins.settings.telescope")
    end,
}
