local Path = require("plenary.path")

local function filepath()
    local bfpath = vim.fn.expand("%:p")
    if bfpath == "" then
        return " "
    end

    return table.concat((Path:new(bfpath)):_split(), " > ")
end

return filepath
