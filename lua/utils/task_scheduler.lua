local task_queue = {}
local worker = coroutine.create(function()
    while true do
        local job = table.remove(task_queue)
        if job == nil then
            coroutine.yield()
        else
            local fn = job.fn
            if job.schedule then
                fn = function()
                    vim.schedule(job.fn)
                end
            else
                fn = job.fn
            end
            fn()
        end
    end
end)

local M = {}

M.schedule = function(fn, use_vim_schedule)
    table.insert(task_queue, {
        fn = fn,
        schedule = use_vim_schedule,
    })
    if coroutine.status(worker) == "suspended" then
        coroutine.resume(worker)
    end
end

M.defer = function(fn, delay, use_vim_schedule)
    vim.defer_fn(function()
        M.schedule(fn, use_vim_schedule)
    end, delay)
end

return M
