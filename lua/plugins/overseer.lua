return {
    "stevearc/overseer.nvim",
    opts = {
        templates = {
            "builtin",
            "btstream.python",
        },
    },
    config = function(_, opts)
        require("overseer").setup(opts)
    end,
}
