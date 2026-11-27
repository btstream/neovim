return {
    "btstream/ade.nvim",
    -- dir = "~/Development/projects_for_opensource/acp.nvim",
    -- dev = true,
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
        -- service = {
        --     path = "~/Development/projects_for_opensource/acp.nvim/service/target/release/nvim_ade_server"
        -- },
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
