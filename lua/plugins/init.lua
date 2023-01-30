vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true }),
    callback = function()
        if vim.tbl_contains({ "dashboard", "directory" }, vim.bo.filetype) then
            vim.cmd([[do User UILoaded]])
        end

        if not require("utils.filetype_tools").is_nonefiletype() then
            vim.cmd([[do User BufReadRealFile]])
            if not require("lazy.core.config").plugins["nvim-lspconfig"]._.loaded then
                vim.defer_fn(function()
                    vim.cmd("do User DeferLoadLsp")
                end, 100)
            end
        end
    end,
})
return {
    "folke/lazy.nvim",
}
