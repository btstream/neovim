local devicons = require("nvim-web-devicons")

local icons = require("themes.icons").common_ui_icons
local is_nonefiletype = require("utils.filetype").is_nonefiletype
local get_mode_color = require("themes.colors.manager").get_mode_color
local get_named_color = require("themes.colors.manager").get_named_color

local path_icon = {
    provider = function()
        return " " .. icons.folder_closed .. ""
    end,
    -- hl = function()
    --     return { fg = get_named_color("blue") }
    -- end,
    condition = function()
        return not is_nonefiletype()
    end,
}

local path_name = {
    provider = function(self)
        local flag, ft = is_nonefiletype()
        if flag then
            -- do not show filetypename for terminal
            if ft == "toggleterm" or ft == "terminal" then
                return ""
            end
            return " " .. ft .. " "
        elseif #self.filename == 0 then
            return " [No Name]"
        else
            local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:~:h")
            local ps = vim.split(path, "/")
            local ps_new = {}
            for i = 1, #ps, 1 do
                if (i == 1 and ps[i] ~= "") or ps[i] == "" or i == #ps then
                    ps_new[i] = ps[i]:gsub("suda:", "")
                    goto continue
                end
                local s = ps[i]:match("[^%u%l%d]?[%u%l%d]")
                ps_new[i] = s
                i = i + 1
                ::continue::
            end

            local p = require("utils.os.path").join(unpack(ps_new))
            -- p = #p > 16 and ps[#ps] or p
            return " " .. p
        end
    end,
}

local file_status = {
    provider = function(self)
        if vim.bo.modified then
            return " " .. icons.file_modified .. " "
        end

        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return " " .. icons.file_readonly .. " "
        end

        if self.filename:match("^suda://") then
            return " " .. icons.file_readonly .. " "
        end
        return " "
    end,
    condition = function()
        return not is_nonefiletype()
    end,
    hl = function(self)
        if vim.bo.modified then
            return { fg = get_named_color("green") }
        end

        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return { fg = get_named_color("orange") }
        end

        if self.filename:match("^suda://") then
            return { fg = get_named_color("red") }
        end
    end,
}

local sep = require("plugins.heirline.components.separator")
local separator = sep({
    char = sep.right_block,
    block = true,
})
separator.condition = function()
    local _, ft = is_nonefiletype()
    return ft ~= "toggleterm"
end

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
        self.filename = vim.api.nvim_buf_get_name(0)
        self.ft = vim.bo.filetype
    end,
    hl = function(self)
        if require("settings").theme.statusline.show_separators then
            local c = { bg = get_named_color("grey") }
            local mc = get_mode_color(self) 
            if not is_nonefiletype() then
               c.fg = mc.bg 
            end
            return c
        end
    end,
    path_icon,
    path_name,
    file_status,
    separator,
    update = {"ModeChanged", "WinEnter", "BufEnter", "BufAdd", "BufWinLeave", "WinClosed", "BufModifiedSet" },
}
