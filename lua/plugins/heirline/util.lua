local nonefiletypes = require("utils.filetype_tools").get_nonfiletypes()

-- setup mode colors
local function gen_mode_color()
    local colors = require("themes.base16.colors").colors()

    -- stylua: ignore start
    local mode_colors = {
        n             = colors.base0D, --"red",
        i             = colors.base0B, --"green",
        v             = colors.base0E, --"cyan",
        V             = colors.base0E, --("cyan"),
        ["\22"]       = colors.base0E, --"cyan",
        c             = colors.base0D, --"orange",
        s             = colors.base0E, --"purple",
        S             = colors.base0E, --"purple",
        ["\19"]       = colors.base0E, --"purple",
        R             = colors.base09, --"orange",
        r             = colors.base09, --"orange",
        ["!"]         = colors.base08, --"red",
        t             = colors.base0B, --"red",
    }
    -- stylua: ignore end

    return mode_colors
end
local mode_colors = gen_mode_color()
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        mode_colors = gen_mode_color()
    end,
})

local M = {}

function M.mode_color(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    local colors = require("themes.base16.colors").colors()
    return { bg = mode_colors[mode], fg = colors.base00 }
end

function M.get_nonefiletype_icon()
    local ft = vim.bo.filetype
    if vim.tbl_contains(nonefiletypes, ft) then
        return require("themes.icons").filetype_icons[ft]
    end
end

return M
