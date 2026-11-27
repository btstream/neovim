return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.splitkeep = "screen"
        require("plugins.edgy.exclusive").setup()
    end,
    opts = function()
        return require("plugins.edgy.views").build()
    end,
}
