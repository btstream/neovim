local uv = vim.uv or vim.loop
return {
    init = function(self)
        self.host = uv.os_gethostname()
    end,
    provider = function(self)
        local s, ft = require("utils.filetype").is_nonefiletype()
        if s and ft ~= "toggleterm" then
            return " 󰢹 "
        end
        return " 󰢹 " .. self.host .. " "
    end,
    -- condition = function()
    --     return require("utils.os.terminal").is_ssh_session() and not require("utils.filetype").is_nonefiletype()
    -- end,
    hl = { fg = "black", bg = "orange" },
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "BufAdd", "WinClosed", "WinLeave" },
}
