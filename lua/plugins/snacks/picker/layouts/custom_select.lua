return {
    -- preview = false,
    layout = {
        backdrop = true,
        relative = "editor",
        width = 0.3,
        min_width = 80,
        height = 0.3,
        min_height = 3,
        box = "vertical",
        border = "rounded",
        title = "{title}",
        title_pos = "center",
        wo = {
            winhighlight = "FloatBorder:LspWinCodeActionBorder,FloatTitle:LspWinCodeActionTitle",
        },
        {
            win = "input",
            height = 1,
            border = "bottom",
            wo = {
                winhighlight = "FloatBorder:LspWinCodeActionBorder,NormalFloat:Normal"
            }
        },
        {
            win = "list",
            border = "none",
            wo = {
                winhighlight = "NormalFloat:Normal"
            }
        },
        -- { win = "preview", title = "{preview}", height = 0.4, border = "top" },
    },
}
