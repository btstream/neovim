----------------------------------------------------------------------
--        hijack netrw manually to make neo-tree loading as         --
--                        lazily as possible                        --
----------------------------------------------------------------------

local hijack_netrw = vim.api.nvim_create_augroup("HijackNetrw", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("silent! autocmd! FileExplorer *")
    end,
    group = hijack_netrw,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        -- work only at opening a directory and neo-tree does not loaded,
        -- as neo-tree registed a autocmd to hijack netrw
        if
            vim.fn.isdirectory(vim.fn.expand("%:p")) == 1
            and require("lazy.core.config").plugins["neo-tree.nvim"]._.loaded == nil
        then
            vim.bo.filetype = "directory" -- a trick to disable winbar for lualine on netrw
            require("plugins.neo-tree.utils").toggle(true, "current")
            vim.api.nvim_del_augroup_by_name("HijackNetrw")
        end
    end,
})
