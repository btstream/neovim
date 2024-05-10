local os = require("utils.os")

local _servers = {
    "bashls",
    "basedpyright",
    "jdtls",
    "rust_analyzer",
    "jsonls",
    "cssls",
    "html",
    "vuels",
    "vimls",
    "lua-language-server",
    "fortls",
    "codelldb",
    "java-debug-adapter",
}

-- lemminx and clangd is not avaiable on arm platform
if os.arch() ~= "arm64" then
    table.insert(_servers, "lemminx")
    table.insert(_servers, "clangd")
end

if vim.fn.has("win32") == 1 then
    table.insert(_servers, "stylua")
    table.insert(_servers, "jq")
end

require("mason").setup()
require("mason-tool-installer").setup({
    ensure_installed = _servers, -- ensure_installed,
    auto_update = true,
})

-- use a schedule to make task kwork in orders
require("mason-tool-installer").run_on_start()
