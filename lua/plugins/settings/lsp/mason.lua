local _servers = {
    "bashls",
    -- "pyright",
    "pylyzer",
    "jdtls",
    "rust_analyzer",
    "jsonls",
    "cssls",
    "html",
    "vuels",
    "vimls",
    "lua-language-server",
    "fortls",
    "lemminx",
    "clangd",
    "codelldb",
    "java-debug-adapter",
}

if vim.fn.has("win32") == 1 then
    table.insert(_servers, "stylua")
    table.insert(_servers, "jq")
end

-- local ensure_installed = {}
-- local lspconfig_to_packages = require("mason-lspconfig.mappings.server").lspconfig_to_package
-- for _, value in ipairs(_servers) do
--     if lspconfig_to_packages[value] then
--         table.insert(ensure_installed, lspconfig_to_packages[value])
--     else
--         table.insert(ensure_installed, value)
--     end
-- end

require("mason").setup()
require("mason-tool-installer").setup({
    ensure_installed = _servers, -- ensure_installed,
    auto_update = true,
})
require("mason-tool-installer").run_on_start()
