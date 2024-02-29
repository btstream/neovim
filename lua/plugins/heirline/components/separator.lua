local get_named_color = require("themes.colors.manager").get_named_color
return function(opts)
    local separator = {
        provider = "",
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
                separator.provider = ""
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
    if os.getenv("TERM_PROGRAM") ~= "WezTerm" and os.getenv("TERM") ~= "xterm-kitty" then
        separator.provider = " "
    end

    return separator
end
