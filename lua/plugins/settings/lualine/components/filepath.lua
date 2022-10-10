local Path = require("plenary.path")

local function filepath()
    local bfpath = vim.fn.expand("%:p")
    if bfpath == "" then
        return " "
    end

    local p = (Path:new(bfpath)):_split()
    if p[1] == "" then
        table.remove(p, 1)
    end

    return table.concat(p, " > ")
end

return filepath
