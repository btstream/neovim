local opt = vim.opt
local filetype_utils = require("utils.filetype")

_G.titlestring = function()
    local s, filetype = filetype_utils.is_nonefiletype()
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
