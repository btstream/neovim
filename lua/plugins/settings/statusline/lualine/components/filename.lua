-- extend filename section to indicate dashboards/terminals and other things
local filename = require("lualine.components.filename"):extend()
-- local update_status = filename.update_status
local TYPES = {
    "NVIMTREE",
    "TERMINAL",
    "DASHBOARD",
    "TOGGLETERM",
    "PACKER",
}
-- override
function filename:update_status(is_focused)
    local filetype = vim.bo.filetype:upper()
    if vim.tbl_contains(TYPES, filetype) then
        return filetype
    end
    return filename.super.update_status(self, is_focused)
end

return filename
