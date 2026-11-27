local icons = require("themes.icons")
local path = require("utils.os.path")
local separator = require("plugins.heirline.components.separator")
local shared = require("plugins.heirline.components.shared")

-- Branch glyph shown until the hosting platform is known (and whenever the
-- remote does not match a known platform).
local DEFAULT_ICON = "\u{e0a0}"

--- Remote icons by repository root. `git remote -v` is probed once per repo,
--- asynchronously; until the probe finishes the entry holds DEFAULT_ICON so a
--- redraw does not spawn the same command again.
---@type table<string, string>
local remote_icon_cache = {}

---@param remote_info string
---@return string
local function icon_for_remote(remote_info)
    if remote_info:match("gitlab") ~= nil then
        return "\u{f296}"
    end

    if remote_info:match("github%.com") ~= nil then
        return "\u{f02a4}"
    end

    if remote_info:match("codeberg%.org") ~= nil then
        return "\u{f330}"
    end

    return DEFAULT_ICON
end

--- Fired after a remote probe finishes. The git component listens to it so
--- heirline drops its frozen per-window cache and re-runs the providers;
--- `redrawstatus` alone would only repaint the stale cached string.
local REFRESH_EVENT = "HeirlineGitRemoteIcon"

---@param git_root_dir string
local function probe_remote_icon(git_root_dir)
    remote_icon_cache[git_root_dir] = DEFAULT_ICON

    vim.system({ "git", "-C", git_root_dir, "remote", "-v" }, { text = true }, function(obj)
        local remote_info = obj.stdout or ""
        remote_icon_cache[git_root_dir] = icon_for_remote(remote_info)

        -- callback runs in a fast event context, touch the editor from the main loop
        vim.schedule(function()
            vim.api.nvim_exec_autocmds("User", { pattern = REFRESH_EVENT })
            if vim.o.laststatus ~= 0 then
                vim.cmd("redrawstatus")
            end
        end)
    end)
end

---@param git_root_dir? string
---@return string
local function remote_icon(git_root_dir)
    if not git_root_dir then
        return DEFAULT_ICON
    end

    local cached = remote_icon_cache[git_root_dir]
    if cached then
        return cached
    end

    probe_remote_icon(git_root_dir)
    return DEFAULT_ICON
end

local git_branch = {
    provider = function(self)
        return " " .. remote_icon(self.git_root_dir) .. " " .. vim.b[0].gitsigns_head .. ""
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
    separator.make(),
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
            -- `.git` is a directory in a normal checkout and a file in a
            -- git worktree / submodule, both mean "repository root"
            if path.exists(path.join(dir, ".git")) then
                self.git_root_dir = dir
                break
            end
        end
    end,
    git_branch,
    git_diff,
    condition = function()
        return not shared.is_nonefiletype()
    end,
    -- No `pattern`: a pattern would also filter the events by buffer name.
    -- BufEnter/WinEnter matter because the repository root is per buffer, and
    -- heirline freezes this subtree while it has an `update` (init included),
    -- so without them the statusline kept the previous buffer's root icon.
    -- "User" covers GitSignsUpdate (branch changes) and the remote icon probe.
    update = { "BufEnter", "WinEnter", "BufWinEnter", "User" },
}
