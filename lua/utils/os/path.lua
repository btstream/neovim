local uv = vim.uv or vim.loop

local M = {}

function M.exists(path)
    return uv.fs_stat(path) ~= nil
end

function M.isdir(path)
    return vim.fn.isdirectory(path) == 1
end

function M.isfile(path)
    local st = uv.fs_stat(path)
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

function M.mkdir(path)
    local p = vim.split(vim.fs.normalize(path), "/")
    local i = 1
    while i <= #p do
        if p[i] == "" then
            i = i + 1
            goto continue
        end

        local s = {}
        for j = 1, i, 1 do
            table.insert(s, p[j])
        end
        local ss = M.join(unpack(s))
        if M.exists(ss) and M.isdir(ss) then
            i = i + 1
            goto continue
        elseif not M.exists(ss) then
            uv.fs_mkdir(ss, 493)
            i = i + 1
        end

        ::continue::
    end
end

function M.ls(path, fn)
    local handle = uv.fs_scandir(path)
    local ret = {}
    while handle do
        local fname, _ = uv.fs_scandir_next(handle)
        if not fname then
            break
        end
        if fn(fname) then
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
