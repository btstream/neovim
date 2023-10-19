local opt = vim.opt
local filetype_tools = require("utils.filetype_tools")

_G.titlestring = function()
    local s, filetype = filetype_tools.is_nonefiletype()
    if s then
        if filetype:upper() == "TOGGLETERM" then
            return "%F"
        end
        return filetype:upper()
    end
    return "%F"
end
opt.title = true
opt.titlestring = [[%{%v:lua.titlestring()%}]]
