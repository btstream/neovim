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
        exclude = {
            filetypes = require("utils.filetype").get_nonfiletypes(),
        },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
}
