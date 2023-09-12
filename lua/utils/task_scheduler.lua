local ordered_task_queue = {}
local task_queue = {}
local workers = {}
for i = 1, 2, 1 do
    local worker = coroutine.create(function()
        while true do
            local job = i == 1 and table.remove(ordered_task_queue, 1) or table.remove(task_queue, 1)
            if job == nil then
                coroutine.yield()
            else
                local fn = job.fn
                if job.schedule then
                    fn = function()
                        vim.schedule(job.fn)
                    end
                end
                pcall(fn)
            end
        end
    end)
    coroutine.resume(worker)
    table.insert(workers, worker)
end

local function wakeup_workers()
    for _, worker in ipairs(workers) do
        if coroutine.status(worker) == "suspended" then
            coroutine.resume(worker)
        end
    end
end

local M = {}

M.schedule = function(fn, opts)
    local ordered = opts and opts.ordered or false
    local use_vim_schedule = opts and opts.use_vim_schedule or false
    local tasklist = ordered and ordered_task_queue or task_queue
    table.insert(tasklist, {
        fn = fn,
        schedule = use_vim_schedule,
    })
    wakeup_workers()
    -- if coroutine.status(worker) == "suspended" then
    --     coroutine.resume(worker)
    -- end
end

M.defer = function(fn, delay, opts)
    vim.defer_fn(function()
        M.schedule(fn, opts)
    end, delay)
end

return M
