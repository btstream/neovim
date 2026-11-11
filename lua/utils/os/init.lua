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

--- get the CPU architecture, normalised to "arm64" or "x64"
---@return string "arm64" for 64-bit ARM | "x64" for everything else
function M.arch()
    os_uname = os_uname or uv.os_uname()
    -- uname returns "arm64" on Apple Silicon, but "aarch64" on Linux and
    -- "ARM64"/"AMD64" on Windows, so compare case-insensitively.
    local machine = tostring(os_uname.machine or ""):lower()

    if machine == "arm64" or machine == "aarch64" or machine:match("^arm") then
        return "arm64"
    end

    return "x64"
end

---@return boolean -- true if in wsl
function M.is_wsl()
    return M.name() == "linux" and vim.fn.has("wsl") == 1
end

return M
