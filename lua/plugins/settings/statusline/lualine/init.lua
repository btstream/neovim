local lsp_progress = require("plugins.settings.statusline.lualine.components.lsp_progress")

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
            { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
        },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { { lsp_progress, padding = { left = 1 }, icon = "" } },
        lualine_z = { { "location", icon = "" } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
