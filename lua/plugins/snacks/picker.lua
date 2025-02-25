return {
    prompt = "   ",
    layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
        end,
    },
    layouts = require("plugins.snacks.layouts"),
    sources = {
        select = {
            layout = {
                preset = "relative_cursor_select",
            }
        }
    }
}
