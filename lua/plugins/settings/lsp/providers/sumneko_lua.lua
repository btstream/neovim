local lspconfig = require("lspconfig")
local config = {
    settings = {
        Lua = {
            format = false,
        },
    },
}

lspconfig.sumneko_lua.setup({
    on_init = function(client)
        local s = {
            Lua = {
                format = {
                    enable = false,
                },
            },
        }
        if vim.fn.getcwd() == vim.fn.stdpath("config") then
            s.Lua["diagnostics"] = { globals = { "vim" } }
            s.Lua["workspace"] = { library = vim.api.nvim_get_runtime_file("", true) }
        end
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, s)
        vim.lsp.rpc.notify("workspace/didChangeConfiguration")
    end,
})
