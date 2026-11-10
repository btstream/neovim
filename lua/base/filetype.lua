vim.filetype.add({
    extension = {
        zsh = "bash",
        json = "jsonc",
        tex = "tex"
    },
    pattern = {
        -- The command-line window buffer is named "[Command Line]".
        -- The pattern is a Lua pattern, so the brackets must be escaped;
        -- unescaped they form a character class and make any single-char
        -- file name built from one of those letters (a, e, m, d, ...)
        -- resolve to this filetype.
        ["%[Command Line%]"] = "cmdline",
    },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.for" },
    callback = function()
        vim.b.fortran_fixed_source = 1
    end,
})
