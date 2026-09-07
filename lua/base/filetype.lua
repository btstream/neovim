vim.filetype.add({
    extension = {
        zsh = "bash",
        json = "jsonc",
        tex = "tex"
    },
    pattern = {
        ["[Command Line]"] = "cmdline",
    },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.for" },
    callback = function()
        vim.b.fortran_fixed_source = 1
    end,
})
