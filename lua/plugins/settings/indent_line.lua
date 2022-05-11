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
        "help",
        "",
    },
})
