local lspconfig_utils = require("lspconfig.util")
lspconfig_utils.default_config.capabilities.offsetEncoding = { "utf-16" }
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
    capabilities = lspconfig_utils.default_config.capabilities,
})
