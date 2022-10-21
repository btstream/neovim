require("lspconfig").clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "-j=12",
        "--clang-tidy",
        "--all-scopes-completion",
        "--header-insertion=iwyu",
        "--pch-storage=disk",
        "--log=verbose",
    },
})