return {
    "iamcco/markdown-preview.nvim",
    build = function()
        vim.cmd("call mkdp#util#install()")
    end,
    module = false,
    ft = { "markdown" },
}
