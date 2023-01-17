return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
        require("plugins.settings.dashboard")
    end,
}
