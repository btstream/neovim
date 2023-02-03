local M = {}

function M.map(specs)
    for _, m in pairs(specs) do
        if #m < 3 then
            return
        end

        local keymap_spec = {}
        -- if is a LazyKey for lazy.nvim
        if m.mode then
            local opts = {}
            for k, v in pairs(m) do
                if type(k) ~= "number" and k ~= "mode" and k ~= "id" then
                    opts[k] = v
                end
            end
            keymap_spec[1] = m.mode
            keymap_spec[2] = m[1]
            keymap_spec[3] = m[2]
            keymap_spec[4] = opts
        else
            keymap_spec = m
        end
        vim.keymap.set(unpack(keymap_spec))
    end
end

return M
