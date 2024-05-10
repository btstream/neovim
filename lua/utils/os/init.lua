local uv = vim.uv or vim.loop

local M = {}

local os_uname

--- get os name
---@return string "windows" for windows | "macos" for macos | "linux" for linux
function M.name()
    os_uname = os_uname or uv.os_uname()

    local sysname = os_uname.sysname:lower()
    if sysname == "darwin" then
        return "macos"
    end

    if sysname == "windows_nt" then
        return "windows"
    end

    return "linux"
end

function M.arch()
    os_uname = os_uname or uv.os_uname()
    local machine = os_uname.machine

    if machine == "aarch64" then
        return "arm64"
    end

    return "x64"
end

---@return boolean -- true if in wsl
function M.is_wsl()
    return M.name() == "linux" and vim.fn.has("wsl") == 1
end

return M
