vim.fn.sign_define("LightBulbSign", { text = "", texthl = "LightBulbSign" })

require("nvim-lightbulb").setup({
    sign = {
        enabled = true,
        priority = 30,
    },
    autocmd = {
        enabled = true,
        -- see :help autocmd-pattern
        pattern = { "*" },
        -- see :help autocmd-events
        events = { "CursorHold", "CursorHoldI" },
    },
})
