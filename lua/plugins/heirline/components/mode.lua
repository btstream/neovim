local mode_icons = require("themes.icons").mode_icons
local get_nonefiletype_icon = require("utils.filetype").get_icon

-- stylua: ignore start
local mode_names = {
    ["n"]        = "NORMAL",
    ["no"]       = "O-PENDING",
    ["nov"]      = "O-PENDING",
    ["noV"]      = "O-PENDING",
    ["no\22"]    = "O-PENDING",
    ["niI"]      = "NORMAL",
    ["niR"]      = "NORMAL",
    ["niV"]      = "NORMAL",
    ["nt"]       = "NORMAL",
    ["v"]        = "VISUAL",
    ["vs"]       = "VISUAL",
    ["V"]        = "V-LINE",
    ["Vs"]       = "V-LINE",
    ["\22"]      = "V-BLOCK",
    ["\22s"]     = "V-BLOCK",
    ["s"]        = "SELECT",
    ["S"]        = "S-LINE",
    ["\19"]      = "S-BLOCK",
    ["i"]        = "INSERT",
    ["ic"]       = "INSERT",
    ["ix"]       = "INSERT",
    ["R"]        = "REPLACE",
    ["Rc"]       = "REPLACE",
    ["Rx"]       = "REPLACE",
    ["Rv"]       = "V-REPLACE",
    ["Rvc"]      = "V-REPLACE",
    ["Rvx"]      = "V-REPLACE",
    ["c"]        = "COMMAND",
    ["cv"]       = "EX",
    ["ce"]       = "EX",
    ["r"]        = "REPLACE",
    ["rm"]       = "MORE",
    ["r?"]       = "CONFIRM",
    ["!"]        = "SHELL",
    ["t"]        = "TERMINAL",
}
-- stylua: ignore end

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    provider = function(self)
        local icon = get_nonefiletype_icon()
        local name = icon == nil and " " .. mode_names[self.mode] or ""
        icon = icon and icon or mode_icons[self.mode]
        return " " .. icon .. name .. " "
    end,
    hl = require("themes.heirline").get_mode_color,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "BufAdd", "WinClosed", "WinLeave" },
}
