vim.g.colors_name = "base16-" .. require("settings").theme.color_scheme
require("base16-colorscheme").setup(require("themes.colors.manager").colors())
require("themes.colors.highlights").set()
require("themes.autocmds")
