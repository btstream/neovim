require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    buftype_exclude = {'terminal', 'dashboard'},
    filetype_exclude = {'dashboard', 'lsp-installer', 'packer', 'Outline', 'NvimTree', "help"}
}
