return {
    "btstream/ade.nvim",
    dependencies = { "folke/edgy.nvim" }, -- 可选，但推荐
    build = function()
        require("ade.service.install").run()
    end,
    cmd = { "Ade", "AdeLog", "AdeDebug" },
    keys = {
        {
            mode = { "n" },
            "<leader>ac",
            "<cmd>Ade<CR>",
            desc = "open sidebar",
        },
        {
            mode = { "n", "i" },
            "<C-k><C-a>",
            "<cmd>Ade<CR>",
            desc = "open ADE sidebar",
        },
    },
    opts = {
        backend = "service",
        transport = {
            prompt_timeout = 0
        },
        layout = {
            backend = "external",
        },
        ui = {
            render = {
                lazy_syntax = true,
                pagination = { enabled = true },
            },
        },
        completion = {
            files = {
                backend = "fd"
            }
        }
    }
}
