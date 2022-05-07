local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup({
    on_init = function(client)
        local settings = vim.fn.getcwd() == vim.fn.stdpath("config")
                -- s.Lua["diagnostics"] = { globals = { "vim" } }
                -- s.Lua["workspace"] = { library = vim.api.nvim_get_runtime_file("", true) }
                and {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    },
                }
            or {}
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, settings)
        vim.lsp.rpc.notify("workspace/didChangeConfiguration")
    end,
})
