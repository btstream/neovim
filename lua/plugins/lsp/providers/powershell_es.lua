require("lspconfig").powershell_es.setup({
    bundle_path = require("utils.os.path").join(
        vim.fn.stdpath("data"),
        "mason",
        "packages",
        "powershell-editor-services"
    ),
})
