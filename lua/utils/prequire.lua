local p = require("plenary.path")

local function equals_or_contain(l, r)
    if type(l) == "string" then
        return l == r
    end

    if type(l) == "table" then
        for _, v in ipairs(l) do
            if v == r then
                return true
            end
        end
    end

    return false
end

--- load all files in module path
---@param modname string
---@param exclude string or table
local function prequire(modname, exclude)
    local a = vim.split(modname, "%.")
    table.insert(a, 1, "lua")
    table.insert(a, 1, vim.fn.stdpath("config"))
    table.insert(a, "*")
    local modpath = p:new(a)
    for _, v in ipairs(vim.split(vim.fn.glob(modpath:absolute()), "\n")) do
        local module = (vim.split(vim.fs.basename(v), "%."))[1]
        if exclude ~= nil and not equals_or_contain(exclude, module) then
            pcall(require, ("%s.%s"):format(modname, module))
        end
    end
end

return {
    prequire = prequire,
}
