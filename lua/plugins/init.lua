local group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true })

local function schedule(fn, delay)
    if delay then
        vim.defer_fn(fn, delay)
    else
        vim.schedule(fn)
    end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = group,
    callback = function()
        local delay = nil
        if vim.fn.argc() > 0 then
            delay = 100
        end

        schedule(function()
            if not require("utils.filetype_tools").is_nonefiletype() then
                -- emit BufReadReadFile event first
                vim.cmd([[do User BufReadRealFile]])
            end
        end, delay)
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    group = group,
    callback = function()
        local delay = nil
        if vim.fn.argc() > 0 then
            delay = 200
        end
        -- defering to next schedule cycle
        schedule(function()
            if not require("utils.filetype_tools").is_nonefiletype() then
                vim.schedule(function()
                    vim.cmd("do User BufReadRealFilePost")
                end)

                -- defering loading lsp
                vim.defer_fn(function()
                    vim.cmd("do User BufReadReadFilePostDefer")
                end, 200)

                pcall(vim.api.nvim_del_augroup_by_id, group)
            end
        end, delay)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyCheck" },
    callback = function()
        vim.defer_fn(function()
            vim.cmd("do User VeryVeryLazy")
            require("utils.lazy").update()
        end, 2000)
    end,
})

return {
    "folke/lazy.nvim",
}
