local buffer = require("galaxyline.providers.buffer")

local M = {}
M.mode_icons = { --- {{{2
    c = "גּ COMMAND",
    ["!"] = "גּ COMMAND",
    i = " INSERT",
    ic = " INSERT",
    ix = " INSERT",
    n = " NORMAL",
    R = "﯒ REPLACE",
    Rv = "﯒ REPLACE",
    r = "﯒ REPLACE",
    rm = "﯒ REPLACE",
    ["r?"] = "﯒ REPLACE",
    s = "ﱐ SELECT",
    S = "ﱐ SELECT",
    [""] = "ﱐ SELECT",
    t = " TERMINAL",
    v = "ﱐ VISUAL",
    V = "ﱐ VISUAL",
}

M.filetype_icons = {
    NVIMTREE = "פּ ",
    HELP = "ﲉ ",
    TOGGLETERM = " ",
    OUTLINE = " ",
    PACKER = " ",
    DAPUI_WATCHES = " ",
    DAPUI_CONFIG = " ",
    DAPUI_SCOPES = " ",
    DAPUI_BREAKPOINTS = " ",
    ["DAP-REPL"] = " ",
    DAPUI_STACKS = " ",
    DEFALT = " ",
}

--- get mode icon
---@return string icon
M.get_mode_icon = function()
    return M.mode_icons[vim.fn.mode()]
end

--- get filetype icon
M.get_filetype_icon = function()
    local buftype = buffer.get_buffer_filetype()
    -- print(buftype)
    local icon = M.filetype_icons[buftype]
    if icon then
        return icon
    else
        return M.filetype_icons.DEFALT
    end
end
return M
