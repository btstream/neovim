return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    enabled = false,
    config = function()
        vim.notify = require("notify").setup({
            timeout = 1500,
            render = "wrapped-default",
            max_width = 50,
        })
    end,
}
