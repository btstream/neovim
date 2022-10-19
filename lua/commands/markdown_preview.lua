vim.api.nvim_create_user_command("MarkdownPreviewInstall", function()
    require("utils.packer").ensure_loaded("markdown-preview.nvim")
    vim.cmd("call mkdp#util#install()")
end, {})
