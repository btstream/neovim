local termapp = require("utils.os.terminal")
local settings = require("settings")

local chars = {
    right = function()
        return "╲"
    end,
    right_block = function()
        if termapp.is_fully_supported() then
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
        if termapp.is_fully_supported() then
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
        hl = { fg = "LightGray" },
    }

    if opts then
        if opts.char then
            separator.provider = opts.char
        end

        if opts.block then
            if not opts.char then
                separator.provider = chars.right_block()
            end
            separator.hl = opts.hl or {
                fg = "grey",
                bg = "gray",
            }
        end

        if opts.condition then
            separator.condition = opts.condition
        end
    end

    if settings.theme.statusline.show_separators == false then
        separator.provider = " "
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
