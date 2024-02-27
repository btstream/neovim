local icons = require("themes.icons")
local separator = require("plugins.heirline.components.separator")

local git_branch = {
    provider = function()
        return "  " .. vim.b[0].gitsigns_head .. " "
    end,
    hl = function()
        return { fg = require("plugins.heirline.util").get_color("LightGrey") }
    end,
    condition = function()
        return vim.b[0].gitsigns_head or vim.b[0].gitsigns_status_dict
    end,
}

local git_changed = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.modified .. " " .. self.git_status.changed
    end,
    hl = function()
        return { fg = require("plugins.heirline.util").get_color("cyan") }
    end,
    condition = function(self)
        return self.git_status and self.git_status.changed > 0
    end,
}

local git_added = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.added .. " " .. self.git_status.added
    end,
    hl = function()
        return {
            fg = require("plugins.heirline.util").get_color("green"),
        }
    end,
    condition = function(self)
        return self.git_status and self.git_status.added > 0
    end,
}

local git_removed = {
    provider = function(self)
        return " " .. icons.gitstatus_icons.deleted .. " " .. self.git_status.removed
    end,
    hl = function()
        return {
            fg = require("plugins.heirline.util").get_color("DarkRed"),
        }
    end,
    condition = function(self)
        return self.git_status and self.git_status.removed > 0
    end,
}

local git_diff = {
    init = function(self)
        self.git_status = vim.b[0].gitsigns_status_dict
    end,
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
    git_branch,
    git_diff,
    update = { "User", pattern = "GitSignsUpdate" },
}
