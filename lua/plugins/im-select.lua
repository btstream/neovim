local function get_backend()
    local function available(command)
        return vim.fn.executable(command) == 1
    end

    if vim.fn.has("macunix") == 1 then
        local command = available("macism") and "macism" or "im-select"
        if available(command) then
            return { query = { command }, default = "com.apple.keylayout.ABC" }
        end
    elseif vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
        local command = available("im-select.exe") and "im-select.exe" or "im-select"
        if available(command) then
            return { query = { command }, default = "1033" }
        end
    elseif available("fcitx5-remote") then
        return { query = { "fcitx5-remote", "-n" }, switch = { "fcitx5-remote", "-s" }, default = "keyboard-us" }
    elseif available("ibus") then
        return { query = { "ibus", "engine" }, default = "xkb:us::eng" }
    elseif available("fcitx-remote") then
        return {
            query = { "fcitx-remote" },
            switch = { "fcitx-remote" },
            default = "1",
            switch_args = { ["1"] = "-c", ["2"] = "-o" },
        }
    end
end

local function run(command)
    -- Wait for each switch so a previous window cannot override the next one.
    local ok, result = pcall(function()
        return vim.system(command, { text = true, timeout = 500 }):wait()
    end)
    if ok and result.code == 0 then
        return vim.trim(result.stdout or "")
    end
end

return {
    "keaising/im-select.nvim",
    cond = function()
        return get_backend() ~= nil
    end,
    config = function()
        local backend = get_backend()
        if not backend then
            return
        end

        require("im_select").setup({
            default_command = backend.query[1],
            set_default_events = {},
            set_previous_events = {},
        })

        local function switch_to(state)
            local arg = backend.switch_args and backend.switch_args[state] or state
            local command = vim.list_extend({}, backend.switch or backend.query)
            command[#command + 1] = arg
            run(command)
        end

        local function enter_insert(win)
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
                return
            end
            local saved = vim.w[win].im_select_insert_state
            if saved then
                switch_to(saved)
            end
        end

        local function leave_insert(win)
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
                return
            end
            local state = run(backend.query)
            if not state or state == "" or (backend.switch_args and not backend.switch_args[state]) then
                return
            end

            vim.w[win].im_select_insert_state = state
            if state ~= backend.default then
                switch_to(backend.default)
            end
        end

        local function is_insert(mode)
            return mode:match("^[iR]") ~= nil
        end

        local group = vim.api.nvim_create_augroup("WindowInputMethod", { clear = true })
        vim.api.nvim_create_autocmd("ModeChanged", {
            group = group,
            callback = function()
                local was_insert = is_insert(vim.v.event.old_mode)
                local now_insert = is_insert(vim.v.event.new_mode)
                if was_insert == now_insert then
                    return
                end
                local win = vim.api.nvim_get_current_win()
                if now_insert then
                    enter_insert(win)
                else
                    leave_insert(win)
                end
            end,
        })

        vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
            group = group,
            callback = function(event)
                if not is_insert(vim.api.nvim_get_mode().mode) then
                    return
                end
                local win = vim.api.nvim_get_current_win()
                if event.event == "WinLeave" then
                    leave_insert(win)
                else
                    enter_insert(win)
                end
            end,
        })
    end,
}
