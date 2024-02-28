local icons = require("themes.icons").common_ui_icons
local is_nonefiletype = require("utils.filetype").is_nonefiletype
local separator = require("plugins.heirline.components.separator")

local ft_indicator = {
    provider = function()
        local _, ft = is_nonefiletype()
        return " " .. ft .. " "
    end,
    condition = function()
        return is_nonefiletype()
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
            servers = "NONE"
        end
        return " " .. icons.lsp_server .. " " .. servers .. " "
    end,
    condition = function()
        return not is_nonefiletype()
    end,
}

return {
    hl = function()
        return { bg = require("plugins.heirline.util").get_color("grey") }
    end,
    separator({ block = "true", char = "" }),
    ft_indicator,
    lsp_indicator,
    update = { "LspAttach", "LspDetach", "WinEnter", "BufEnter", "BufLeave", "WinLeave" },
}
