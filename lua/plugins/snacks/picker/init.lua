return {
    prompt = "    ",
    layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function(source)
            if string.match(source, "^diagnostics.*") then
                return "diagnostics"
            end
            if string.match(source, "^lsp_.*") then
                return "lsp"
            end
            return vim.o.columns >= 120 and "spotlight" or "vertical"
        end,
    },
    layouts = require("plugins.snacks.picker.layouts"),
    sources = {
        select = {
            layout = {
                preset = "cursor_select",
            }
        },
    }
}
