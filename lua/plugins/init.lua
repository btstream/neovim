local group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = group,
    callback = function()
        if vim.tbl_contains({ "dashboard", "directory" }, vim.bo.filetype) then
            vim.cmd([[do User UILoaded]])
        end

        if not require("utils.filetype_tools").is_nonefiletype() then
            -- emit BufReadReadFile event first
            vim.cmd([[do User BufReadRealFile]])
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    group = group,
    callback = function()
        -- defering to next schedule cycle
        vim.schedule(function()
            if not require("utils.filetype_tools").is_nonefiletype() then
                vim.schedule(function()
                    vim.cmd("do User BufReadRealFilePost")
                end)

                -- defering loading lsp
                vim.defer_fn(function()
                    vim.cmd("do User LoadLsp")
                end, 200)

                vim.api.nvim_del_augroup_by_name("CustomBufRead")
            end
        end)
    end,
})

return {
    "folke/lazy.nvim",
}
