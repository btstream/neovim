vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true }),
    callback = function()
        if not require("utils.filetype_tools").is_nonefiletype() then
            vim.cmd([[do User BufReadRealFile]])
        end
    end,
})
return {
    "folke/lazy.nvim",
}
