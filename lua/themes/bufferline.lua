local function gen_base16_hg()
    local colors = require("themes.base16.colors").colors()
    local dbg = require("themes.utils").darken(colors.base00, 0.15)
    -- local dbg020 = require("themes.utils").darken(colors.base00, 0.20)

    return {
        fill = {
            fg = dbg,
            bg = dbg,
        },
        background = {
            bg = dbg,
        },
        tab = {
            bg = dbg,
        },
        -- tab_selected = {
        --     fg = "tabline_sel_bg",
        --     bg = "<colour-value-here>",
        -- },
        tab_close = {
            bg = dbg,
        },
        close_button = {
            bg = dbg,
        },
        close_button_visible = {
            bg = dbg,
        },
        -- close_button_selected = {
        --     bg = dbg015,
        -- },
        buffer = {
            bg = dbg,
        },
        buffer_visible = {
            bg = dbg,
        },
        -- buffer_selected = {
        --     fg = "normal_fg",
        --     bg = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        numbers = {
            bg = dbg,
        },
        numbers_visible = {
            bg = dbg,
        },
        -- numbers_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        diagnostic = {
            bg = dbg,
        },
        diagnostic_visible = {
            bg = dbg,
        },
        -- diagnostic_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        hint = {
            bg = dbg,
        },
        hint_visible = {
            bg = dbg,
        },
        -- hint_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        hint_diagnostic = {
            bg = dbg,
        },
        hint_diagnostic_visible = {
            bg = dbg,
        },
        -- hint_diagnostic_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        -- info = {
        --     fg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        -- },
        info_visible = {
            bg = dbg,
        },
        -- info_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        info_diagnostic = {
            bg = dbg,
        },
        info_diagnostic_visible = {
            bg = dbg,
        },
        -- info_diagnostic_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        warning = {
            bg = dbg,
        },
        warning_visible = {
            bg = dbg,
        },
        -- warning_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        warning_diagnostic = {
            bg = dbg,
        },
        warning_diagnostic_visible = {
            bg = dbg,
        },
        -- warning_diagnostic_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     -- sp = warning_diagnostic_fgg
        --     bold = true,
        --     italic = true,
        -- },
        error = {
            bg = dbg,
        },
        error_visible = {
            bg = dbg,
        },
        -- error_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        error_diagnostic = {
            bg = dbg,
        },
        error_diagnostic_visible = {
            bg = dbg,
        },
        -- error_diagnostic_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     sp = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        -- modified = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        -- },
        modified_visible = {
            bg = dbg,
        },
        -- modified_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        -- },
        -- duplicate_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     italic = true,
        -- },
        duplicate_visible = {
            bg = dbg,
        },
        duplicate = {
            bg = dbg,
            italic = true,
        },
        separator_selected = {
            fg = dbg,
            bg = dbg,
        },
        separator_visible = {
            fg = dbg,
            bg = dbg,
        },
        separator = {
            fg = dbg,
            bg = dbg,
        },
        indicator_selected = {
            fg = colors.base0D,
            bg = colors.base00,
        },
        indicator_visible = {
            bg = dbg,
            fg = dbg,
        },
        -- pick_selected = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        -- pick_visible = {
        --     bg = dbg,
        -- },
        -- pick = {
        --     fg = "<colour-value-here>",
        --     bg = "<colour-value-here>",
        --     bold = true,
        --     italic = true,
        -- },
        offset_separator = {
            bg = dbg,
            fg = colors.base00,
        },
    }
end

local function highlight()
    local b = true
    if vim.g.colors_name ~= nil then
        b, _ = vim.g.colors_name:find("base16")
        b = b or require("settings").theme.color == "base16"
    end
    -- if base16 color scheme
    if b then
        return gen_base16_hg()
    end
end

return {
    highlights = highlight,
}
