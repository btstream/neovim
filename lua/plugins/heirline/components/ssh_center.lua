return {
    require("plugins.heirline.components.separator")({
        block = true,
        char = "",
        hl = { fg = "orange", bg = "gray" },
    }),
    vim.tbl_extend("force", require("plugins.heirline.components.ssh"), {
        provider = function(self)
            return " 󰢹 " .. self.host .. " "
        end,
        condition = function()
            return require("utils.os.terminal").is_ssh_session() and require("utils.filetype").is_nonefiletype()
        end,
    }),
    require("plugins.heirline.components.separator")({
        block = true,
        char = "",
        hl = { fg = "orange", bg = "gray" },
    }),
    condition = function()
        return require("utils.os.terminal").is_ssh_session() and require("utils.filetype").is_nonefiletype()
    end,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "BufAdd", "WinClosed", "WinLeave" },
}
