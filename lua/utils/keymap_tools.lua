local M = {}

--- set key maps in batch mode
---@param specs table table of keymap definations. Support the format of LazyKey or the form of vim.keymap.et
function M.map(specs, bufnr)
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

        if bufnr then
            if keymap_spec[4] then
                keymap_spec[4].bufnr = bufnr
            else
                keymap_spec[4] = {
                    bufnr = bufnr,
                }
            end
        end

        vim.keymap.set(unpack(keymap_spec))
    end
end

--- Genrate LazyKey format from key defines
---@param specs table
---@return table {LazyKey}
function M.to_lazy_key(specs)
    local ret = {}
    for _, spec in pairs(specs) do
        if spec.mode then
            table.insert(ret, spec)
        else
            local s = spec[4] and spec[4] or {}
            s.mode = spec[1]
            s[1] = spec[2]
            s[2] = spec[3]
            table.insert(ret, s)
        end
    end
    return ret
end

return M
