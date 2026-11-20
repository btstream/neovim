-- Dispatch startup events in order instead of guessing how long each stage takes.
-- The queue orders event handlers, not asynchronous work started by plugins.
local api = vim.api
local group = api.nvim_create_augroup("CustomBufRead", { clear = true })
local queue = {}
local running = false

-- Run one queued task per scheduler turn so earlier handlers can return
-- before the next startup stage begins.
local function drain()
    local task = table.remove(queue, 1)
    if not task then
        running = false
        return
    end

    -- Yield between stages, and keep draining even if a handler fails.
    local ok, err = xpcall(task, debug.traceback)
    vim.schedule(drain)
    if not ok then
        error(err, 0)
    end
end

-- Append a task and start the queue only if it is idle. Multiple autocmds
-- can enqueue work without starting competing drains.
local function enqueue(task)
    queue[#queue + 1] = task
    if not running then
        running = true
        vim.schedule(drain)
    end
end

-- Dispatch a named User event for lazy-loading subscribers without processing
-- buffer modelines; no file is being read by this function.
local function emit(event)
    api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
end

-- Keep the existing event names because lazy-loading specs subscribe to them.
local file_events = { "BufReadRealFile", "BufReadRealFilePost", "BufReadReadFilePostDefer" }
local phase = 1
local file_pending = false
local file_buf
local very_lazy_ready = false

-- Queue VeryVeryLazy once lazy.nvim signals readiness and no file stages
-- are outstanding. An empty startup does not wait for a file.
local function enqueue_very_lazy()
    if very_lazy_ready and ((phase == 1 and not file_pending) or phase > #file_events) then
        very_lazy_ready = false
        enqueue(function()
            emit("VeryVeryLazy")
        end)
    end
end

-- Check whether a buffer can trigger file setup. Use the same check when
-- queuing and dispatching because the buffer may change in between.
local function is_file(buf)
    return api.nvim_buf_is_loaded(buf)
        and vim.bo[buf].buftype == ""
        and api.nvim_buf_get_name(buf) ~= ""
        and not require("utils.filetype").is_nonefiletype(buf)
end

-- Find a real window for the next file event. Prefer the selected file while
-- it is visible, then look in the current tab before checking other tabs.
local function find_file_window()
    if file_buf and is_file(file_buf) then
        local win = vim.fn.win_findbuf(file_buf)[1]
        if win then
            return win
        end
    end

    for _, win in ipairs(api.nvim_tabpage_list_wins(0)) do
        if is_file(api.nvim_win_get_buf(win)) then
            return win
        end
    end
    for _, win in ipairs(api.nvim_list_wins()) do
        if is_file(api.nvim_win_get_buf(win)) then
            return win
        end
    end
end

-- Dispatch one file stage. Put its continuation ahead of later tasks, or
-- pause until another file window is available if there is no valid target.
local function run_file_event()
    local win = find_file_window()
    if not win then
        -- Keep the phase so the next eligible window resumes without replaying earlier events.
        file_pending = false
        enqueue_very_lazy()
        return
    end

    file_buf = api.nvim_win_get_buf(win)
    local event = file_events[phase]
    phase = phase + 1
    if file_events[phase] then
        table.insert(queue, 1, run_file_event)
    else
        -- These events are one-shot startup triggers, not per-buffer notifications.
        api.nvim_del_augroup_by_id(group)
        enqueue_very_lazy()
    end

    -- Use a real window: nvim_buf_call can use a scratch window for a hidden
    -- buffer, where any window-local settings made by handlers would be lost.
    api.nvim_win_call(win, function()
        emit(event)
    end)
end

-- Start or resume the file stages when a file window becomes available.
-- Listen to WinEnter too: two windows can show the same buffer.
api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = group,
    callback = function(ev)
        if not is_file(ev.buf) then
            return
        end

        if not file_pending then
            file_buf = ev.buf
            file_pending = true
            enqueue(run_file_event)
        end
    end,
})

-- Remember when lazy.nvim is ready; the queue decides when to emit VeryVeryLazy.
api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        very_lazy_ready = true
        enqueue_very_lazy()
    end,
})
