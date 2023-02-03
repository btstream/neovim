vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
    -- pattern = "*",
    callback = function()
        -- if vim.fn.expand("%f") == "[Command Line]" then
        vim.bo.ft = "cmdline"
        -- end
    end,
})
