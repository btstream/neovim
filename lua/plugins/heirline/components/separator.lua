local get_named_color = require("themes.colors.manager").get_named_color
local termapp = require("utils.termapps")

local chars = {
    right = function()
        return "╲"
    end,
    right_block = function()
        if termapp.is_wezterm_or_kitty() then
            return ""
        end

        if termapp.is_iterm() then
            return ""
        end

        return "🭀"
    end,
    left = function()
        return "╱"
    end,
    left_block = function()
        if termapp.is_wezterm_or_kitty() then
            return ""
        end

        if termapp.is_iterm() then
            return ""
        end

        return "🭋"
    end,
}

local function make(opts)
    local separator = {
        provider = chars.right(),
        hl = function()
            return { fg = get_named_color("LightGray") }
        end,
    }

    if opts then
        if opts.char then
            separator.provider = opts.char
        end

        if opts.block then
            if not opts.char then
                separator.provider = chars.right_block()
            end
            separator.hl = function()
                return {
                    fg = get_named_color("grey"),
                    bg = get_named_color("gray"),
                }
            end
        end

        if opts.condition then
            separator.condition = opts.condition
        end
    end

    -- do not use separators in terminals like konsole or iterm
    -- if os.getenv("TERM_PROGRAM") ~= "WezTerm" and os.getenv("TERM") ~= "xterm-kitty" then
    --     separator.provider = " "
    -- end

    return separator
end

return setmetatable({}, {
    __call = function(_, opts)
        return make(opts)
    end,
    __index = function(_, k)
        if chars[k] then
            return chars[k]()
        end
    end,
})
