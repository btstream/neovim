local exclude_filetypes = {}
for _, v in pairs(require("utils.filetype").get_nonfiletypes()) do
    table.insert(exclude_filetypes, v)
end
table.insert(exclude_filetypes, "fortran")
return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        indent = { char = "▏" },
        scope = {
            show_start = false,
            show_end = false,
            highlight = "IndentBlanklineContextChar",
        },
        exclude = { filetypes = exclude_filetypes },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
}
