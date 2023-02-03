return {
    "iamcco/markdown-preview.nvim",
    build = function()
        vim.cmd("call mkdp#util#install()")
    end,
    cmd = "MarkdownPreviewInstall",
    init = function()
        vim.api.nvim_create_user_command("MarkdownPreviewInstall", function()
            vim.cmd("call mkdp#util#install()")
        end, {})
    end,
    module = false,
    ft = { "markdown" },
}
