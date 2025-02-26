return {
    layout = {
        box = "vertical",
        width = 0.7,
        min_width = 120,
        height = 0.8,
        {
            title = "{title}",
            box = "vertical",
            border = "single",
            { win = "input", height = 1, border = "single" },
            height = 2
        },
        -- {
        --     box = "vertical",,
        --     border = "single",
        --     title = "{title} {live} {flags}",
        --     {
        --         win = "input",
        --         height = 1,
        --         border = "single",
        --         wo = {
        --             winhighlight =
        --             "FloatBorder:TelescopePromptBorder,NormalFloat:TelescopePromptNormal,FloatTitle:TelescopePromptTitle",
        --         }
        --     },
        --     {
        --         win = "list",
        --         border = "single",
        --         wo = {
        --             winhighlight = "FloatBorder:TelescopePromptBorder,NormalFloat:TelescopeNormal"
        --         }
        --     },
        -- },
        {
            box = "horizontal",
            border = "none",
            { win = "list",    border = "single", width = 0.4 },
            { win = "preview", border = "single", width = 0.6 },
        },
        -- { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
    },
}
