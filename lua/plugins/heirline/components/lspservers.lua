local devicons = require("nvim-web-devicons")
local icons = require("themes.icons").common_ui_icons
local is_nonefiletype = require("utils.filetype").is_nonefiletype
local current_buf_type = require("utils.filetype").current_buf_type
local separator = require("plugins.heirline.components.separator")
local ft_namemapper = require("plugins.heirline.ft-namemapper")

local ft_indicator = {
    provider = function()
        local _, ft = is_nonefiletype()
        return " " .. ft_namemapper[ft] .. " "
    end,
    condition = function()
        return is_nonefiletype() and current_buf_type() ~= "snacks_terminal"
    end,
}

local file_icons = {
    init = function(self)
        local filename = vim.api.nvim_buf_get_name(0)
        local ext = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_colors = devicons.get_icon_color(filename, ext)
        self.icon = self.icon or icons.file_common
        if filename == "" then
            self.icon = icons.file_new
        end
    end,
    provider = function(self)
        return " " .. self.icon .. ""
    end,
    hl = function(self)
        return { fg = self.icon_colors }
    end,
    condition = function()
        return not is_nonefiletype()
    end,
}

local lsp_indicator = {
    init = function(self)
        self.clients = {}
        local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = 0 }) or vim.lsp.get_active_clients()
        for _, client in pairs(clients) do
            if client.name == "null-ls" then
                goto continue
            end
            table.insert(self.clients, client.name)
            ::continue::
        end
    end,
    provider = function(self)
        local servers = table.concat(self.clients, ",")
        if #self.clients == 0 then
            return " " .. vim.bo.filetype .. " "
        end
        -- return " " .. servers .. " "
        return " " .. vim.bo.filetype .. " [" .. servers .. "] "
    end,
    condition = function()
        return not is_nonefiletype()
    end,
}

return {
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { bg = "grey" }
        end
    end,
    separator({ block = "true", char = separator.left_block }),
    ft_indicator,
    file_icons,
    lsp_indicator,
    update = { "LspAttach", "LspDetach", "WinEnter", "BufEnter", "BufLeave", "WinLeave", "BufWinEnter", "BufWinLeave" },
}
