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

return M
