return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("indent_blankline").setup({
            space_char_blankline = " ",
            show_current_context = true,
            -- show_end_of_line = true,
            buftype_exclude = { "terminal", "dashboard" },
            filetype_exclude = {
                "TelescopePrompt",
                "TelescopePreview",
                "dashboard",
                "lsp-installer",
                "packer",
                "Outline",
                "NvimTree",
                "neo-tree",
                "help",
                "lspinfo",
                "Trouble",
                "mason",
                "dapui_breakpoints",
                "dapui_scopes",
                "dap-repl",
                "dapui_console",
                "lazy",
                "neo-tree-popup",
                "",
            },
        })
    end,
}
