local termapp = require("utils.os.terminal")
local shared = require("plugins.heirline.components.shared")

local M = {}

-- Glyph constants, resolved once for the current terminal at require time.
M.right = "╲"

M.right_block = (function()
    if termapp.is_fully_supported() then
        return "\u{e0b8}"
    end

    if termapp.is_iterm() then
        return "\u{e0c8}"
    end

    return "🭀"
end)()

M.left = "╱"

M.left_block = (function()
    if termapp.is_fully_supported() then
        return "\u{e0ba}"
    end

    if termapp.is_iterm() then
        return "\u{e0ca}"
    end

    return "🭋"
end)()

--- Build a separator component.
---@param opts? { char?: string, block?: boolean, hl?: table, condition?: function }
---@return table
function M.make(opts)
    local separator = {
        provider = M.right,
        hl = { fg = "LightGray" },
    }

    if opts then
        if opts.char then
            separator.provider = opts.char
        end

        if opts.block then
            if not opts.char then
                separator.provider = M.right_block
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

    -- only an explicit `false` blanks the separator, as before the refactor
    if shared.show_separators() == false then
        separator.provider = " "
    end

    return separator
end

return M
