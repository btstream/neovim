return {
    layout = {
        box = "vertical",
        width = 0.7,
        min_width = 120,
        height = 0.8,
        { win = "input", height = 1, title = "{flags} {title}", border = "rounded" },
        {
            box = "horizontal",
            {
                win = "list",
                border = "single",
                width = 0.4,
                wo = {
                    statuscolumn = " "
                }
            },
            {
                win = "preview",
                border = "single",
                wo = {
                    number = false,
                    statuscolumn = "   ",
                    winbar = ""
                }
            }
        }
    },
}
