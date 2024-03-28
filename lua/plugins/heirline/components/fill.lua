local uv = vim.uv or vim.loop
local terminal = require("utils.os.terminal")
local filetype = require("utils.filetype")
return {
    provider = "%=",
    hl = { bg = "gray" },
    update = "ColorScheme",
}
