return {
    "ahmedkhalf/project.nvim",
    event = { "User BufReadRealFilePost", "User LazyVimStarted" },
    dependencies = "Shatur/neovim-session-manager",
    config = function()
        require("plugins.settings.project_and_session")
    end,
}
