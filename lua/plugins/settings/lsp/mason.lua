local _servers = {
    "bashls",
    "pyright",
    "jdtls",
    "rust_analyzer",
    "jsonls",
    "cssls",
    "html",
    "vuels",
    "vimls",
    "sumneko_lua",
    "fortls",
    "lemminx",
    "clangd",
    "codelldb",
    "java-debug-adapter",
}
local ensure_installed = {}
local lspconfig_to_packages = require("mason-lspconfig.mappings.server").lspconfig_to_package
for _, value in ipairs(_servers) do
    if lspconfig_to_packages[value] then
        table.insert(ensure_installed, lspconfig_to_packages[value])
    else
        table.insert(ensure_installed, value)
    end
end

require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = needed,
-- })
require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    auto_update = true,
})
require("mason-tool-installer").run_on_start()
