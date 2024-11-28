local fs = require("efmls-configs.fs")

local formatter = "xmlformat"
local command = string.format("%s --indent 4 --blanks --preserve-attributes -", fs.executable(formatter))

return {
    formatCanRange = true,
    formatCommand = command,
    formatStdin = true,
}
