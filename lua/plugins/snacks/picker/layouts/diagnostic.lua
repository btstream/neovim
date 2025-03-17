return {
    preview = "main",
    layout = {
        height = 0.3,
        box = "vertical",
        position = "bottom",
        border = "top",
        wo = {
            winhighlight = "FloatBorder:VertSplit",
        },
        {
            win = "list",
            wo = { winhighlight = "NormalFloat:Normal" },
            bo = {
                filetype = "snacks_diagnostics"
            }
        },
        {
            win = "input",
            height = 1,
            wo = { winhighlight = "NormalFloat:Normal" },
            bo = { filetype = "snacks_diagnostics" },
        },
        {
            win = "preview",
            wo = {
                winbar = ""
            }
        }
    },
}
