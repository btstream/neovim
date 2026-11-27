local get_mode_color = require("themes.heirline").get_mode_color
local path_utils = require("utils.os.path")
local ft_namemapper = require("plugins.heirline.ft-namemapper")
local separator = require("plugins.heirline.components.separator")
local shared = require("plugins.heirline.components.shared")
local file_status = require("plugins.heirline.components.file_status")

local path_icon = {
    provider = function()
        return " "
    end,
    hl = function(self)
        return { fg = get_mode_color(self).bg }
    end,
    condition = function()
        return not shared.is_nonefiletype()
    end,
}

local path_name = {
    provider = function(self)
        local flag, ft = shared.is_nonefiletype()
        if flag then
            -- do not show filetypename for terminal
            if ft == "snacks_terminal" or ft == "terminal" then
                return ""
            end

            return " " .. ft_namemapper[ft] .. " "
        elseif #self.filename == 0 then
            return " [No Name]"
        else
            local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:~:h")
            local ps = vim.split(path, "/")
            local ps_new = {}
            for i = 1, #ps do
                if (i == 1 and ps[i] ~= "") or ps[i] == "" or i == #ps then
                    ps_new[i] = ps[i]:gsub("suda:", "")
                else
                    ps_new[i] = ps[i]:match("[^%u%l%d]?[%u%l%d]")
                end
            end

            local p = path_utils.join(unpack(ps_new))
            return " " .. p
        end
    end,
}

local separator_component = separator({
    char = separator.right_block,
    block = true,
})
separator_component.condition = function()
    local _, ft = shared.is_nonefiletype()
    return ft ~= "snacks_terminal"
end

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
        self.filename = vim.api.nvim_buf_get_name(0)
        self.ft = vim.bo.filetype
    end,
    hl = function(self)
        if shared.show_separators() then
            return { bg = "grey" }
        end
    end,
    path_icon,
    path_name,
    file_status,
    separator_component,
    update = shared.update.path,
}
