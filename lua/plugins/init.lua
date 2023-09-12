vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyCheck" },
    callback = function()
        -- vim.defer_fn(function()
        --     require("utils.lazy").update()
        -- end, 2000)
        require("utils.task_scheduler").defer(function()
            require("utils.lazy").update()
        end, 2000, { ordered = true })
    end,
})
return {
    "folke/lazy.nvim",
}
