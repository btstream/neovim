return {
    "folke/which-key.nvim",
    event = { "User UILoaded", "User BufReadRealFilePost" },
    config = function()
        require("which-key").setup({ window = { border = "solid" } })
    end,
}
