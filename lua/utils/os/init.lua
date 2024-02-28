local uv = vim.uv or vim.loop

local M = {}

--- get os name
---@return string "windows" for windows | "macos" for macos | "linux" for linux
M.name = function()
    local os_uname = uv.os_uname().sysname:lower()
    if os_uname == "darwin" then
        return "macos"
    end

    if os_uname == "windows_nt" then
        return "windows"
    end

    return "linux"
end

---@return boolean -- true if in wsl
M.is_wsl = function()
    return M.name() == "linux" and vim.fn.has("wsl") == 1
end

return M
