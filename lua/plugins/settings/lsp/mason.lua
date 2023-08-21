local _servers = {
    "bashls",
    "pyright",
    -- "pylyzer",
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

require("mason").setup()
require("mason-tool-installer").setup({
    ensure_installed = _servers, -- ensure_installed,
    auto_update = true,
})

-- use a schedule to make task kwork in orders
require("utils.task_scheduler").schedule(function()
    require("mason-tool-installer").run_on_start()
end)
