require("base.vim-options")
require("base.hijack-netrw")
if vim.fn.has("nvim-0.9") == 1 then
    require("base.statuscolumn")
end
require("base.quit-behave")
require("base.filetype")
require("base.custom-settings")
