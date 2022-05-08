require("cosmic-ui").setup({
    -- default border to use
    -- 'single', 'double', 'rounded', 'solid', 'shadow'
    border_style = "solid",

    -- rename popup settings
    rename = {
        border = {
            highlight = "LspFloatBorder",
            style = "solid",
            title = " Rename ",
            title_align = "left",
            title_hl = "LspNormalFloat",
        },
        prompt = "> ",
        prompt_hl = "LspNormalFloat",
    },

    code_actions = {
        min_width = nil,
        border = {
            bottom_hl = "LspFloatBorder",
            highlight = "LspFloatBorder",
            style = "solid",
            title = "Code Actions",
            title_align = "center",
            title_hl = "LspNormalFloat",
        },
    },
})
