local M = {}

M._keytype = {
    LazySpecOnly = 1,
    LazyWithAction = 2,
    Normal = 3,
}

M._parsed_spec = {}

local function get_specs(modules)
    local settings = require("settings")
    local s, config = pcall(require, "keymaps.default." .. modules)
    config = s and config or nil

    if settings.keys and settings.keys[modules] and vim.tbl_count(settings.keys[modules]) > 0 then
        local c = settings.keys[modules]
        if c.append then
            table.move(c, 1, #c, #config + 1, config)
        else
            c.append = nil
            config = c
        end
    end

    return config
end

local function parse(spec)
    local islazy = spec.mode or #spec < 3
    if islazy then
        local s = {}
        if spec.mode then
            if #spec > 1 then -- must have rhs, need to set as map
                s[1] = spec.mode and spec.mode or "n"
                s[2] = spec[1]
                s[3] = spec[2]
                local opts = {}
                for k, v in pairs(spec) do
                    if type(k) ~= "number" and k ~= "mode" and k ~= "id" then
                        opts[k] = v
                    end
                end
                spec[4] = opts
            end
            return M._keytype.LazyWithAction, s
        else
            return M._keytype.LazySpecOnly, spec
        end
    else
        return M._keytype.Normal, spec
    end
end

local function to_lazykey(spec)
    local ret = {}
    ret.mode = spec[1]
    ret[1] = spec[2]
    ret[2] = spec[3]
    if spec[4] then
        for k, v in pairs(spec[4]) do
            ret[k] = v
        end
    end
    return ret
end

local function init(module)
    if not M._parsed_spec[module] then
        local generated_keys = {
            actions = {},
            lazykeys = {},
        }

        local specs = get_specs(module)

        for _, s in pairs(specs) do
            local type, k = parse(s)
            if type == M._keytype.Normal then
                table.insert(generated_keys.actions, k)
                -- table.insert(generated_keys.lazykeys, to_lazykey(k))
            elseif type == M._keytype.LazyWithAction then
                k.lazy = true
                table.insert(generated_keys.actions, k)
                table.insert(generated_keys.lazykeys, s)
            else
                table.insert(generated_keys.lazykeys, s)
            end
        end

        M._parsed_spec[module] = generated_keys
    end
end

local function set(module)
    return function(bufnr, ignore_lazy)
        init(module) --make sure key is parsed, if parsed, do nothing
        for _, v in pairs(M._parsed_spec[module].actions) do
            if ignore_lazy and v.lazy then
                goto continue
            end

            if bufnr then
                if v[4] then
                    v[4].buffer = bufnr
                else
                    v[4] = { buffer = bufnr }
                end
            end
            vim.keymap.set(unpack(v))

            ::continue::
        end
    end
end

local function lazy_keys(module)
    return function()
        init(module)
        -- print(vim.inspect(M._parsed_spec[module].lazykeys))
        return M._parsed_spec[module].lazykeys
    end
end

-- init basic loading
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        require("keymaps").base.set()
    end,
})

return setmetatable({}, {
    __index = function(_, module)
        return setmetatable({}, {
            __index = function(_, func)
                if func == "set" then
                    return set(module)
                end

                if func == "lazy_keys" then
                    return lazy_keys(module)
                end
            end,
        })
    end,
})
