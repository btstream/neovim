return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("indent_blankline").setup({
            space_char_blankline = " ",
            show_current_context = true,
            -- show_end_of_line = true,
            buftype_exclude = { "terminal", "dashboard", "noice" },
            -- filetype_exclude = table.insert(require("utils.filetype_tools").get_nonfiletypes(), ""),
            filetype_exclude = require("utils.filetype_tools").get_nonfiletypes(),
        })
    end,
}
