return {
    "ahmedkhalf/project.nvim",
    event = { "User BufReadRealFilePost", "User LazyVimStarted" },
    dependencies = "Shatur/neovim-session-manager",
    config = function()
        require("project_nvim").setup({})
    end,
}
