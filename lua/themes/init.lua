require("themes.autocmds")
local colors = require("themes.colors.manager").colors()
require("base16-colorscheme").setup(colors)
require("themes.colors.highlights").set()
