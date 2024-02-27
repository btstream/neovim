return function(opts)
    local separator = {
        provider = "",
        hl = function()
            return { fg = require("plugins.heirline.util").get_color("LightGray") }
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
                    fg = require("plugins.heirline.util").get_color("grey"),
                    bg = require("plugins.heirline.util").get_color("gray"),
                }
            end
        end
    end
    return separator
end
