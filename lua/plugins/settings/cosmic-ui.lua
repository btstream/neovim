require("cosmic-ui").setup({
    -- default border to use
    -- 'single', 'double', 'rounded', 'solid', 'shadow'
    notify_title = "Lsp Server",
    border_style = "solid",

    -- rename popup settings
    rename = {
        border = {
            highlight = "LspWinRenameBorder",
            style = "rounded",
            title = " Rename ",
            title_align = "left",
            title_hl = "LspWinRenameTitle",
        },
        prompt = "> ",
        prompt_hl = "LspWinRenamePrompt",
    },

    code_actions = {
        min_width = nil,
        border = {
            bottom_hl = "LspWinCodeActionBorder",
            highlight = "LspWinCodeActionBorder",
            style = "rounded",
            title = "Code Actions",
            title_align = "center",
            title_hl = "LspWinCodeActionTitle",
        },
    },
})
