return {
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
    opts = {
        -- options
        progress = {
            poll_rate = 1,
            ignore_done_already = true,
            suppress_on_insert = true,
            ignore = { "efm" },
            display = {
                render_limit = 5,
                done_icon = "󰄬"
            }
        }
    },
}
