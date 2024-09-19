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

        local map = require("utils.keymap").set
        map({
            { { "i", "n" }, "<F5>", "<cmd>OverseerRun<cr>", { desc = "Run current file" } },
        })
    end,
}
