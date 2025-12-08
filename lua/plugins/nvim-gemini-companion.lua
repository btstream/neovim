return {
    "gutsavgupta/nvim-gemini-companion",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        require("gemini").setup({
            cmds = { "qwen" },
            win = {
                highlights = {
                    NGCNormal = { link = 'Normal' },
                    NGCNormalMC = { link = 'Normal' },
                    NGCFloatBorder = { link = 'VertSplit' },
                },
            },
        })

        vim.api.nvim_create_autocmd({ "Filetype" }, {
            pattern = "terminalGemini",
            callback = vim.schedule_wrap(function()
                vim.opt_local.winbar = ""
            end)
        })
    end,
    cond = function()
        return vim.fn.executable("qwen") == 1
    end,
    keys = {
        { "<leader>gg", "<cmd>GeminiToggle<cr>",      desc = "Toggle Gemini sidebar" },
        { "<leader>gc", "<cmd>GeminiSwitchToCli<cr>", desc = "Spawn or switch to AI session" },
        {
            "<leader>gS",
            function()
                vim.cmd('normal! gv')
                vim.cmd("'<,'>GeminiSend")
            end,
            mode = { 'x' },
            desc = 'Send selection to AI'
        },
    }
}
