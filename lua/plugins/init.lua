vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true }),
    callback = function()
        if vim.tbl_contains({ "dashboard", "directory" }, vim.bo.filetype) then
            vim.cmd([[do User UILoaded]])
        end

        if not require("utils.filetype_tools").is_nonefiletype() then
            -- emit BufReadReadFile event first
            vim.cmd([[do User BufReadRealFile]])

            -- in case of lsp not loaded emit a LoadLsp event to load Lsp, for the saituation
            -- of openning file directly from cli
            if not require("lazy.core.config").plugins["nvim-lspconfig"]._.loaded then
                vim.defer_fn(function()
                    vim.cmd("do User LoadLsp")
                end, 100)
            end

            vim.defer_fn(function()
                vim.cmd("do User BufReadRealFilePost")
            end, 150)
        end
    end,
})
return {
    "folke/lazy.nvim",
}
