local uv = vim.uv or vim.loop
local is_ssh_session = require("utils.os.terminal").is_ssh_session
local shared = require("plugins.heirline.components.shared")

return {
    init = function(self)
        self.host = uv.os_gethostname()
    end,
    provider = function(self)
        local s, ft = shared.is_nonefiletype()
        if s and ft ~= "toggleterm" then
            return " 󰢹 "
        end
        return " 󰢹 " .. self.host .. " "
    end,
    condition = function()
        return is_ssh_session()
    end,
    hl = { fg = "black", bg = "orange" },
    update = shared.update.mode,
}
