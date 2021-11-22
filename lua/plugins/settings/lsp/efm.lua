local util = require('lspconfig.util')
local config = {
    init_options = { documentFormatting = true, codeAction = false, document_formatting = true },
    filetypes = { 'lua' },
    settings = {
        rootMarkers = { '.git' },
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120 " ..
                        "--break-after-table-lb --break-before-table-rb --align-table-field --chop-down-table --chop-down-kv-table" ..
                        " --spaces-inside-table-braces",
                    formatStdin = true
                }
            }
        }
    },
    root_dir = function(fname)
        return util.root_pattern('.git')(fname) or vim.fn.getcwd()
    end
}
return config

