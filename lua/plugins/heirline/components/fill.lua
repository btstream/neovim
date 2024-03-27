local uv = vim.uv or vim.loop
local terminal = require("utils.os.terminal")
local filetype = require("utils.filetype")
return {
    provider = function()
        if terminal.is_ssh_session() and filetype.is_nonefiletype() then
            return "%= 󰢹 " .. uv.os_gethostname() .. "  %="
        end
        return "%="
    end,
    hl = function()
        if terminal.is_ssh_session() and filetype.is_nonefiletype() then
            return { bg = "gray", fg = "orange" }
        end
        return { bg = "gray" }
    end,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "BufAdd", "WinClosed", "WinLeave" },
    -- update = "ColorScheme",
}
