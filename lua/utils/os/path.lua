local uv = vim.uv or vim.loop

local M = {}

M.exists = function(path)
    return uv.fs_stat(path) ~= nil
end

M.isdir = function(path)
    return vim.fn.isdirectory(path) == 1
end

M.isfile = function(path)
    local st = uv.fs_stat(path)
    return st ~= nil and st.type == "file"
end

-- M.islink = function(path)
--     local st = uv.fs_lstat(path)
--     return st ~= nil and st.type == "link"
-- end

M.join = function(...)
    if vim.fs.joinpath then
        return vim.fs.joinpath(...)
    end
    return (table.concat({ ... }, "/"):gsub("//+", "/"))
end

M.basename = function(path)
    return vim.fs.basename(path)
end

M.dirname = function(path)
    return vim.fs.dirname(path)
end

M.extname = function(path)
    return vim.fn.fnamemodify(path, ":e")
end

return M
