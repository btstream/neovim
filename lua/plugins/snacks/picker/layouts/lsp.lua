return {
    layout = {
        backdrop = false,
        relative = "editor",
        box = "horizontal",
        height = 0.5,
        border = { "▁", "▁", "▁", "", "▔", "▔", "▔", "" },
        wo = {
            winhighlight = "FloatBorder:LspRefDefPreviewBorder",
        },
        {
            win = "preview",
            width = .75,
            wo = {
                winbar = ""
            },
        },
        {
            box = "vertical",
            {
                win = "input",
                height = 1,
            },
            {
                win = "list",
            }
        }
    }
}
