-- local navic_loaded, navic = pcall(require, "nvim-navic")

local filetype_tools = require("plugins.settings.lualine.utils.filetype_tools")

local mode = require("plugins.settings.lualine.components.mode")
local filename = require("plugins.settings.lualine.components.filename")
local search_result = require("plugins.settings.lualine.components.search_result")
local terminal_info = require("plugins.settings.lualine.components.terminal_info")
local lsp_progress = require("plugins.settings.lualine.components.lsp_progress")
local nft_indicator = filetype_tools.type

local function get_debug_color()
    return { bg = vim.g.dap_loaded and (vim.g.terminal_color_5 or "#c678dd") }
end

filetype_tools.add_none_filetypes({
    "NVIMTREE",
    "TERMINAL",
    "DASHBOARD",
    "TOGGLETERM",
    "PACKER",
    "TELESCOPEPROMPT",
    "OUTLINE",
    "HELP",
    "LSP-INSTALLER",
    "TROUBLE",
    "MASON",
})

-- for filetypes to disable winbar
local disabled_winbar = {
    "NvimTree",
    "Outline",
}
for _, value in ipairs(filetype_tools._nonefiletypes) do
    table.insert(disabled_winbar, value:lower())
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = require("settings").theme.statusline.theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            winbar = disabled_winbar,
        },
        always_divide_middle = false,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            {
                mode,
                color = get_debug_color,
                padding = { left = 1, right = 0 },
                -- separator = { right = "" },
                separator = { right = "" },
            },
            {
                function()
                    return "(DEBUG)"
                end,
                color = get_debug_color,
                padding = { left = 0, right = 1 },
                cond = function()
                    return vim.g.dap_loaded
                end,
                separator = { right = "" },
            },
        },
        lualine_b = {
            {
                "filetype",
                icon_only = true,
                padding = { right = 1, left = 1 },
                separator = { right = "" },
                cond = function()
                    return not filetype_tools.is_nonefiletype()
                end,
            },
            {
                nft_indicator,
                cond = function()
                    return filetype_tools.is_nonefiletype()
                end,
            },
            {
                filename,
                symbols = { modified = " ", readonly = " ", unnamed = " [No Name]" },
                padding = { left = 0, right = 1 },
            },
        },
        lualine_c = {
            {
                terminal_info,
                cond = function()
                    return vim.bo.filetype:upper() == "TOGGLETERM"
                end,
            },
            {
                "branch",
                cond = function()
                    return not filetype_tools.is_nonefiletype()
                end,
            },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
            {
                "diagnostics",
                symbols = { error = " ", warn = " ", hint = " ", info = " " },
                update_in_insert = true,
            },
        },

        lualine_x = {
            { search_result, icon = { "" }, color = { fg = vim.g.terminal_color_11 or "#e5c07b" } },
            {
                "encoding",
                cond = function()
                    return not filetype_tools.is_nonefiletype()
                end,
            },
            {
                "fileformat",
                cond = function()
                    return not filetype_tools.is_nonefiletype()
                end,
            },
        },
        lualine_y = {
            {
                lsp_progress,
                padding = 1,
                cond = function()
                    return packer_plugins["lsp-status.nvim"].loaded and not filetype_tools.is_nonefiletype()
                end,
            },
            {
                nft_indicator,
                cond = function()
                    return filetype_tools.is_nonefiletype()
                end,
            },
        },
        lualine_z = {
            {
                "location",
                icon = "",
                color = get_debug_color,
                separator = { left = "" },
                cond = function()
                    return not filetype_tools.is_nonefiletype()
                end,
            },
            {
                mode,
                cond = function()
                    return filetype_tools.is_nonefiletype()
                end,
                separator = { left = "" },
                padding = { right = 0, left = 1 },
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {
        lualine_b = {
            {
                require("plugins.settings.lualine.components.filepath"),
                color = { bg = "NONE" },
                -- padding = { left = 1, right = 1 },
            },
            {
                "filetype",
                icon_only = true,
                color = { bg = "NONE" },
                padding = { left = 0, right = 0 },
            },
            {
                filename,
                symbols = { modified = "", readonly = "", unnamed = "" },
                color = { bg = "NONE" },
            },
            {
                function()
                    return "›"
                end,
                padding = { left = 0, right = 0 },
                cond = function()
                    return packer_plugins["nvim-navic"].loaded and require("nvim-navic").get_location({}) ~= ""
                end,
                color = { bg = "NONE" },
            },
        },
        lualine_c = {
            {
                function()
                    return require("nvim-navic").get_location()
                end,
                cond = function()
                    return packer_plugins["nvim-navic"].loaded and require("nvim-navic").is_available()
                end,
            },
        },
    },
    inactive_winbar = {
        lualine_b = {
            {
                require("plugins.settings.lualine.components.filepath"),
                color = { bg = "NONE" },
            },
            {
                "filetype",
                icon_only = true,
                color = { bg = "NONE" },
                padding = { left = 0, right = 0 },
            },
            {
                filename,
                symbols = { modified = "", readonly = "", unnamed = "" },
                color = { bg = "NONE" },
            },
        },
    },
    extensions = {},
})
