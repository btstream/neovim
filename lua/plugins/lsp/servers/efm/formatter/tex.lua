-- as taxlab client does not support textDocument/formatting method, use
-- efm with latexindent for formatting tex sourcefiles
local fs = require('efmls-configs.fs')

local formatter = 'latexindent'
local command = string.format(
    "%s --local=.indentconfig.yaml -m '${INPUT}'",
    fs.executable(formatter, fs.Scope.NODE)
)

return {
    formatCanRange = true,
    formatCommand = command,
    formatStdin = true,
    rootMarkers = {
        ".indentconfig.yaml",
        "indentconfig.yaml",
        "latexindent.yaml",
        ".latexindent.yaml",
        ".git"
    },
}
