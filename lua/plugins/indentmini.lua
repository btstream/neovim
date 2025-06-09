local exclude_filetypes = {}
for _, v in pairs(require("utils.filetype").get_nonfiletypes()) do
    table.insert(exclude_filetypes, v)
end
table.insert(exclude_filetypes, "fortran")
return {
    "nvimdev/indentmini.nvim",
    -- event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        char = "▏",
        exclude = exclude_filetypes
    }
}
