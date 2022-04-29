local lsp_progress = require("plugins.settings.statusline.lualine.components.lsp_progress")
local filename = require("plugins.settings.statusline.lualine.components.filename")
local colors = require("material.colors")
local function get_debug_color()
    return { bg = vim.g.dap_loaded and colors.darkpurple }
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "material",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = false,
        globalstatus = false,
    },
    sections = {
        lualine_a = {
            {
                "mode",
                color = get_debug_color,
                separator = { right = "" },
            },
        },
        lualine_c = {
            "branch",
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
            { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
        },
        lualine_b = {
            {
                filename,
                symbols = { modified = " ", readonly = " ", unnamed = " " },
                cond = function()
                    return vim.fn.expand("%:t") ~= ""
                end,
            },
        },
        lualine_x = {
            "encoding",
            {
                "fileformat",
                cond = function()
                    return vim.fn.expand("%:t") ~= ""
                end,
            },
            "filetype",
        },
        lualine_y = { { lsp_progress, padding = { left = 1 }, icon = "" } },
        lualine_z = { { "location", icon = "", color = get_debug_color } },
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
