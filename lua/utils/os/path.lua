local uv = vim.uv or vim.loop

local M = {}

--- Expand leading ~ only. Full vim.fn.expand() would also mangle
--- %, # in filenames (same class of bug as :write with raw names).
local function expand_home(path)
    if type(path) == "string" and vim.startswith(path, "~") then
        return vim.fn.expand(path)
    end
    return path
end

---@param path string|nil
---@return boolean
function M.exists(path)
    if type(path) ~= "string" then
        return false
    end
    return uv.fs_stat(expand_home(path)) ~= nil
end

---@param path string|nil
---@return boolean
function M.isdir(path)
    if type(path) ~= "string" then
        return false
    end
    return vim.fn.isdirectory(expand_home(path)) == 1
end

---@param path string|nil
---@return boolean
function M.isfile(path)
    if type(path) ~= "string" then
        return false
    end
    local st = uv.fs_stat(expand_home(path))
    return st ~= nil and st.type == "file"
end

-- M.islink = function(path)
--     local st = uv.fs_lstat(path)
--     return st ~= nil and st.type == "link"
-- end

function M.join(...)
    if vim.fs.joinpath then
        return vim.fs.joinpath(...)
    end
    return (table.concat({ ... }, "/"):gsub("//+", "/"))
end

function M.basename(path)
    return vim.fs.basename(path)
end

function M.dirname(path)
    return vim.fs.dirname(path)
end

function M.extname(path)
    return vim.fn.fnamemodify(path, ":e")
end

--- Create a directory and all missing parents.
--- Never loops: delegates to vim.fn.mkdir(path, "p").
---@param path string
---@return boolean ok, string|nil err
function M.mkdir(path)
    -- vim.fn.mkdir(nil) turns nil into the string "v:null" and happily
    -- creates such a directory, so validate the argument first.
    if type(path) ~= "string" or path == "" then
        return false, "mkdir: path must be a non-empty string"
    end

    local ok, result = pcall(vim.fn.mkdir, expand_home(path), "p")
    if not ok then
        return false, tostring(result)
    end
    if result == 0 then
        return false, "mkdir failed: " .. path
    end
    return true, nil
end

--- List entries of a directory.
--- @param path string
--- @param filter? fun(name: string): boolean keep the entry only when true
---@return string[]
function M.ls(path, filter)
    if type(path) ~= "string" then
        return {}
    end
    local handle = uv.fs_scandir(expand_home(path))
    local ret = {}
    while handle do
        local fname, _ = uv.fs_scandir_next(handle)
        if not fname then
            break
        end
        if filter == nil or filter(fname) then
            table.insert(ret, fname)
        end
    end
    return ret
end

function M.find_root(markers, start)
    -- 定义各种项目类型的标识文件
    local root_markers = markers ~= nil and markers or {
        -- Git 仓库
        '.git',
        -- Node.js
        'package.json', 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml',
        -- Python
        'pyproject.toml', 'setup.py', 'requirements.txt', 'Pipfile',
        -- Rust
        'Cargo.toml',
        -- Go
        'go.mod',
        -- Java
        'pom.xml', 'build.gradle', 'settings.gradle',
        -- Tectonic
        "Tectonic.toml",
        -- C/C++
        'CMakeLists.txt', 'Makefile',
        -- 其他
        '.project', '.root', ".nvim"
    }

    return vim.fs.root(start and start or 0, root_markers)
end

return M
