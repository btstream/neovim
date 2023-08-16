vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyCheck" },
    callback = function()
        -- vim.defer_fn(function()
        --     require("utils.lazy").update()
        -- end, 2000)
        require("utils.task_scheduler").schedule(function()
            require("utils.lazy").update()
        end)
    end,
})
return {
    "folke/lazy.nvim",
}
