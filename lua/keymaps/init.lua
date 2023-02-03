local function get(key)
    local settings = require("settings")
    local s, config = pcall(require, "keymaps." .. key)
    config = s and config or nil

    if settings.keys and settings.keys[key] and vim.tbl_count(settings.keys[key]) > 0 then
        local c = settings.keys[key]
        if c.append then
            table.move(c, 1, #c, #config + 1, config)
        else
            c.append = nil
            config = c
        end
    end

    return config
end

require("utils.keymap_tools").map(get("base"))

return setmetatable({}, {
    __index = function(_, key)
        return get(key)
    end,
})
