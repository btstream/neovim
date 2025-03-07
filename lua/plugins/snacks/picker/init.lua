return {
    prompt = "    ",
    layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
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
        lsp_declarations = { layout = { preset = "lsp" } },
        lsp_definitions = { layout = { preset = "lsp" } },
        lsp_implementations = { layout = { preset = "lsp" } },
        lsp_references = { layout = { preset = "lsp" } },
        diagnostics = { layout = { preset = "diagnostics" } },
        diagnostics_buffer = { layout = { preset = "diagnostics" } },
    }
}
