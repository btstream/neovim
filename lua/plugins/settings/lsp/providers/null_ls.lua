local find_stylua_config = require("lspconfig.util").root_pattern("stylua.toml", ".stylua.toml")

require("null-ls").setup({
    on_attach = require("plugins.settings.lsp.utils").on_attach,
    sources = {
        require("null-ls").builtins.formatting.stylua.with({
            extra_args = function(_)
                local path = find_stylua_config(vim.fn.expand("%:p") or vim.fn.getcwd()) or vim.fn.getcwd()
                for _, value in pairs({ "stylua.toml", ".stylua.toml" }) do
                    local configfile = vim.fn.expand(string.format("%s/%s", path, value))
                    if vim.fn.glob(configfile) ~= "" then
                        return {
                            "-f",
                            configfile,
                        }
                    end
                end
                return { "--indent-type", "Spaces", "--indent-width", "4" }
            end,
        }),
        require("null-ls").builtins.formatting.jq,
        require("null-ls").builtins.formatting.yapf,
    },
})
