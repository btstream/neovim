require("lspconfig").bashls.setup({
    filetypes = { "sh", "bash", "zsh" },
    root_dir = function(fname)
        return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.fnamemodify(fname, ":p:h")
    end,
})
