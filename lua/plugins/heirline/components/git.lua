local icons = require("themes.icons")
local path = require("utils.os.path")

local is_nonefiletypes = require("utils.filetype").is_nonefiletype

local separator = require("plugins.heirline.components.separator")

local git_branch = {
    provider = function(self)
        if self.icon == nil then
            self.icon = ""

            if self.git_root_dir then
                local remote_info = vim.fn.system("git -C " .. self.git_root_dir .. " remote -v")

                if remote_info:match("gitlab") ~= nil then
                    self.icon = ""
                end

                if remote_info:match("github%.com") ~= nil then
                    self.icon = "󰊤"
                end
            end
        end

        return " " .. self.icon .. " " .. vim.b[0].gitsigns_head .. ""
    end,
    hl = { fg = "LightGrey" },
    condition = function()
        return vim.b[0].gitsigns_head or vim.b[0].gitsigns_status_dict
    end,
    on_click = {
        callback = function()
            vim.cmd("Telescope git_branches")
        end,
        name = "statusline_git_branches",
    },
}

local git_changed = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.modified .. " " .. self.git_status.changed
    end,
    hl = { fg = "cyan" },
    condition = function(self)
        return self.git_status and self.git_status.changed > 0
    end,
}

local git_added = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.added .. " " .. self.git_status.added
    end,
    hl = { fg = "green" },
    condition = function(self)
        return self.git_status and self.git_status.added > 0
    end,
}

local git_removed = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.deleted .. " " .. self.git_status.removed
    end,
    hl = { fg = "DarkRed" },
    condition = function(self)
        return self.git_status and self.git_status.removed > 0
    end,
}

local git_diff = {
    init = function(self)
        self.git_status = vim.b[0].gitsigns_status_dict
    end,
    {
        provider = " ",
    },
    separator(),
    git_changed,
    git_added,
    git_removed,
    condition = function()
        local git_status = vim.b[0].gitsigns_status_dict
        return git_status and (git_status.added or 0) + (git_status.removed or 0) + (git_status.changed or 0) > 0
    end,
}

return {
    init = function(self)
        self.git_root_dir = nil
        for dir in vim.fs.parents(vim.fs.normalize(vim.api.nvim_buf_get_name(0))) do
            if path.isdir(path.join(dir, ".git")) then
                self.git_root_dir = dir
                break
            end
        end
        vim.g.in_git_repo = self.git_root_dir
    end,
    git_branch,
    git_diff,
    condition = function()
        return not is_nonefiletypes()
    end,
    update = { "User", pattern = "GitSignsUpdate" },
}
