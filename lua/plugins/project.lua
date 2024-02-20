return {
    "ahmedkhalf/project.nvim",
    event = { "User BufReadRealFilePost" },
    dependencies = "Shatur/neovim-session-manager",
    config = function()
        require("plugins.settings.project_and_session")
    end,
}
