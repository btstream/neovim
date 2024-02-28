local util = require("lspconfig").util
require("lspconfig").pylyzer.setup({
    root_dir = function(fname)
        local root_files = {
            "setup.py",
            "tox.ini",
            "requirements.txt",
            "Pipfile",
            "pyproject.toml",
        }
        return util.root_pattern(unpack(root_files))(fname)
            or util.find_git_ancestor(fname)
            or vim.fn.fnamemodify(fname, ":p:h")
    end,
})
