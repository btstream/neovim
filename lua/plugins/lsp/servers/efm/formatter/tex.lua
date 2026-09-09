-- as taxlab client does not support textDocument/formatting method, use
-- efm with latexindent for formatting tex sourcefiles
local os = require("utils.os")
local path = require("utils.os.path")
local fs = require('efmls-configs.fs')

local formatter = 'latexindent'
-- use latexindent from system first
if os.name() == "linux" and path.exists("/usr/bin/latexindent") then
    formatter = "/usr/bin/latexindent"
end

local command = string.format(
    "%s --local=.indentconfig.yaml -m -",
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
