local uv = vim.uv or vim.loop
local path = require("utils.os.path")

local M = {}

--- helper function to load module, if is a normal mordule file, just load it
--- if it's a directory, load all modules in it. Only support modules in
--- `vim.fn.stdpath("config") .. "/lua" folder`
---@param module
function M.require_all(module)
    local module_path = path.join(vim.fn.stdpath("config"), "lua", unpack(vim.split(module, ".", { plain = true })))
    if path.isfile(module_path) then
        pcall(require, module)
    end

    if path.isdir(module_path) then
        local handle = uv.fs_scandir(module_path)
        while handle do
            local name, t = uv.fs_scandir_next(handle)
            if not name then
                break
            end

            local fname = path.join(module_path, name)
            t = t or uv.fs_stat(fname).type

            if t == "file" and name:sub(-4) == ".lua" then
                pcall(require, module .. "." .. name:sub(1, -5))
            end

            if t == "directory" then
                if path.isdir(path.join(module_path, name, "init.lua")) then
                    pcall(require, module .. "." .. name)
                end
            end
        end
    end
end

--- load a lua file
---@param file string full path of the file to load
function M.require_file(file)
    local s, r = pcall(dofile, file)
    if s then
        return r
    end
    vim.notify(r, vim.log.levels.WARN)
end

return M
