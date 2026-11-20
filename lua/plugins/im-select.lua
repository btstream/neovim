-- The system has one active input method; remember the last one used in each Neovim window.
-- Restore it when typing resumes and return to the default layout when leaving input mode.
-- Ignore transient mode changes caused by background rendering.

-- query reads the current input method. switch is an optional command prefix and defaults to query.
-- default is the state used outside input mode; switch_args maps states to command-line arguments.
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
    -- On Linux, prefer Fcitx5, then IBus, then legacy Fcitx.
    elseif available("fcitx5-remote") then
        return { query = { "fcitx5-remote", "-n" }, switch = { "fcitx5-remote", "-s" }, default = "keyboard-us" }
    elseif available("ibus") then
        return { query = { "ibus", "engine" }, default = "xkb:us::eng" }
    elseif available("fcitx-remote") then
        -- Legacy Fcitx only tracks whether input is active, not which method is selected.
        return {
            query = { "fcitx-remote" },
            switch = { "fcitx-remote" },
            default = "1",
            switch_args = { ["1"] = "-c", ["2"] = "-o" },
        }
    end
end

-- Run the command asynchronously with a 500 ms timeout; handle completion on Neovim's main loop.
-- The callback receives trimmed stdout (possibly empty) on success, or nil on failure.
local function run(command, callback)
    local ok = pcall(vim.system, command, { text = true, timeout = 500 }, vim.schedule_wrap(function(result)
        callback(result.code == 0 and vim.trim(result.stdout or "") or nil)
    end))
    if not ok then
        callback(nil)
    end
end

return {
    "keaising/im-select.nvim",
    -- Load only when a supported input method command is available.
    cond = function()
        return get_backend() ~= nil
    end,
    config = function()
        local backend = get_backend()
        if not backend then
            return
        end

        -- Disable the plugin's shared global state in favor of per-window save and restore.
        require("im_select").setup({
            default_command = backend.query[1],
            set_default_events = {},
            set_previous_events = {},
        })

        -- Copy the command prefix before appending an argument so the backend config stays intact.
        local function switch_to(state, callback)
            local arg = backend.switch_args and backend.switch_args[state] or state
            local command = vim.list_extend({}, backend.switch or backend.query)
            command[#command + 1] = arg
            run(command, callback)
        end

        -- Only modifiable buffers in Insert or Replace mode count as input targets.
        local function input_window()
            local mode = vim.api.nvim_get_mode().mode
            -- Ctrl-O runs a temporary Normal command within the same input session.
            if (mode:match("^[iR]") or mode:match("^ni[IRV]$")) and vim.bo.modifiable then
                return vim.api.nvim_get_current_win()
            end
        end

        -- The last handled input window, or nil if no window was accepting input.
        local active_win = input_window()
        -- pending coalesces queued events; busy serializes backend requests.
        local busy, pending = false, false
        -- Track retries for the current target and reset the count when the target changes.
        local retry_win, retries
        local request_sync

        local function sync_input_method()
            local previous, current = active_win, input_window()
            if previous == current then
                retries = 0
                return
            end
            if current ~= retry_win or not retries then
                retry_win, retries = current, 0
            end

            -- Restore the destination directly, without switching to the default layout first.
            -- A window without a saved state inherits the current input method.
            local target = current and vim.w[current].im_select_insert_state
            if not current then
                target = backend.default
            end
            -- If there is nothing to save or restore, just track the new window.
            if not previous and not target then
                active_win = current
                retries = 0
                return
            end

            busy = true
            local function finish(success)
                busy = false
                if success then
                    active_win = current
                    retries = 0
                end
                -- Recheck if focus or mode changed while the backend was running.
                if input_window() ~= current then
                    retries = 0
                    request_sync()
                elseif not success and retries < 2 then
                    -- Allow up to two retries, each scheduled after 100 ms.
                    retries = retries + 1
                    vim.defer_fn(request_sync, 100)
                end
            end

            run(backend.query, function(state)
                -- Ignore stale or invalid query results before saving or switching.
                if input_window() ~= current or not state or state == ""
                    or (backend.switch_args and not backend.switch_args[state])
                then
                    finish(false)
                    return
                end
                -- Save the previous window's state only if the window still exists.
                if previous and vim.api.nvim_win_is_valid(previous) then
                    vim.w[previous].im_select_insert_state = state
                end
                -- Skip the switch if the current input method already matches the target.
                if target and target ~= state then
                    switch_to(target, function(result)
                        finish(result ~= nil)
                    end)
                else
                    finish(true)
                end
            end)
        end

        request_sync = function()
            if busy or pending then
                return
            end
            pending = true
            -- Check after the event batch to ignore transient i -> n -> i changes, such as ADE scrolling.
            vim.schedule(function()
                pending = false
                sync_input_method()
            end)
        end

        -- Mode changes, window changes, and buffer changes can all affect the input target.
        local group = vim.api.nvim_create_augroup("WindowInputMethod", { clear = true })
        vim.api.nvim_create_autocmd({ "ModeChanged", "WinEnter", "WinClosed", "BufEnter" }, {
            group = group,
            callback = request_sync,
        })
    end,
}
