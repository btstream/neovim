-- Shared bits for the statusline components: the single entry point for
-- none-filetype detection, the separator visibility switch and the autocmd
-- groups that the components use to refresh themselves.
local filetype = require("utils.filetype")
local settings = require("settings")

local M = {}

--- Unified entry point for "is this a panel/terminal-like buffer?" checks.
---@param buf? integer
---@return boolean, string
M.is_nonefiletype = filetype.is_nonefiletype

--- Icon configured for the current buffer's filetype, if any.
M.get_nonefiletype_icon = filetype.get_icon

--- Filetype of the current buffer.
M.current_buf_type = filetype.current_buf_type

--- Whether separator glyphs should be drawn.
---@return boolean
function M.show_separators()
    return settings.theme.statusline.show_separators
end

-- 'modified' option changes; OptionSet exists since Neovim 0.13.
local modified_option_event = vim.fn.has("nvim-0.13") == 1 and "OptionSet" or "BufModifiedSet"

--- Autocmd groups reused by the components.
---@type table<string, string[]>
M.update = {
    -- mode/ssh badges: refresh on every mode or window/buffer switch
    mode = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "BufAdd", "WinClosed", "WinLeave" },
    -- path segment: also follows directory changes and the 'modified' flag
    path = {
        "ModeChanged",
        "WinEnter",
        "BufEnter",
        "BufAdd",
        "BufWinLeave",
        "WinClosed",
        modified_option_event,
        "DirChanged",
    },
    -- cursor position segment
    location = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "CursorMoved", "CursorMovedI" },
    -- lsp server listing
    lsp = { "LspAttach", "LspDetach", "WinEnter", "BufEnter", "BufLeave", "WinLeave", "BufWinEnter", "BufWinLeave" },
}

return M
