local M = {}

function M.set(maps)
    for _, v in ipairs(maps) do
        vim.keymap.set(unpack(v))
    end
end

return M
