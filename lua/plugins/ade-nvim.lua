return {
    "btstream/ade.nvim",
    dependencies = { "folke/edgy.nvim" }, -- 可选，但推荐
    build = function()
        require("ade.service.install").run()
    end,
    cmd = { "Ade", "AdeLog", "AdeDebug" },
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
