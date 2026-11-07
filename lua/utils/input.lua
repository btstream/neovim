local M = {}

local ns = vim.api.nvim_create_namespace("utils.input.secret")

---Hide every character of the input buffer behind a "*" without touching the
---buffer content, so consumers still read the real text.
---@param buf integer
---@param win integer
local function conceal(buf, win)
    if not (vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(win)) then
        return
    end

    vim.wo[win].conceallevel = 2
    vim.wo[win].concealcursor = "nvic"

    local function redraw()
        if not vim.api.nvim_buf_is_valid(buf) then
            return
        end
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        local line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
        for i = 0, vim.fn.strchars(line) - 1 do
            local start = vim.str_byteindex(line, i)
            local stop = vim.str_byteindex(line, i + 1)
            vim.api.nvim_buf_set_extmark(buf, ns, 0, start, { end_col = stop, conceal = "*" })
        end
    end

    redraw()
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
        buffer = buf,
        callback = redraw,
    })
end

---Like `vim.ui.input()`, but never echoes the typed value.
---
---The registered `vim.ui.input` only supports `opts.secret` if it advertises it.
---For snacks' buffer based input the value is concealed in place, and for the
---plain command-line based implementation `inputsecret()` is used.
---@param prompt string
---@param on_confirm fun(value?: string)
function M.secret(prompt, on_confirm)
    local ok_info, info = pcall(debug.getinfo, vim.ui.input, "S")
    local source = ok_info and info.source or ""

    if source:match("snacks[/\\]input%.lua$") then
        local ok, snacks = pcall(require, "snacks")
        if ok and snacks.input then
            local win = snacks.input({ prompt = prompt }, on_confirm)
            vim.schedule(function()
                conceal(win.buf, win.win)
            end)
            return
        end
    end

    -- other implementations (dressing.nvim, ...) support `secret`
    if not source:match("vim[/\\]ui%.lua$") then
        vim.ui.input({ prompt = prompt, secret = true }, on_confirm)
        return
    end

    vim.fn.inputsave()
    local value = vim.fn.inputsecret(prompt)
    vim.fn.inputrestore()
    on_confirm(value ~= "" and value or nil)
end

return M
