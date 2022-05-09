local onedark = require("onedarkpro")
local utils = require("onedarkpro.utils")
local onedarkstyle = "onedark"

onedark.setup({
    theme = onedarkstyle,
    colors = {
        onedark = {
            telescope_prompt = utils.lighten(onedark.get_colors("onedark").bg, 0.97),
            telescope_results = utils.darken(onedark.get_colors("onedark").bg, 0.85),
        },
        onelight = {
            telescope_prompt = utils.darken(onedark.get_colors("onelight").bg, 0.98),
            telescope_results = utils.darken(onedark.get_colors("onelight").bg, 0.95),
        },
    },
    filetype_hlgroups_ignore = {
        filetypes = {
            "^aerial$",
            "^alpha$",
            "^fugitive$",
            "^fugitiveblame$",
            "^help$",
            "^NvimTree$",
            "^packer$",
            "^qf$",
            "^startify$",
            "^startuptime$",
            "^TelescopePrompt$",
            "^TelescopeResults$",
            "^terminal$",
            "^toggleterm$",
        },
        buftypes = {
            "^terminal$",
        },
    },
    hlgroups = {
        -- Telescope
        TelescopeBorder = {
            fg = "${telescope_results}",
            bg = "${telescope_results}",
        },
        TelescopePromptBorder = {
            fg = "${telescope_prompt}",
            bg = "${telescope_prompt}",
        },
        TelescopePromptCounter = { fg = "${fg}" },
        TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
        TelescopePromptPrefix = {
            fg = "${purple}",
            bg = "${telescope_prompt}",
        },
        TelescopePromptTitle = {
            fg = "${telescope_prompt}",
            bg = "${purple}",
        },

        TelescopePreviewTitle = {
            fg = "${telescope_results}",
            bg = "${green}",
        },
        TelescopeResultsTitle = {
            fg = "${telescope_results}",
            bg = "${telescope_results}",
        },

        TelescopeMatching = { fg = "${purple}" },
        TelescopeNormal = { bg = "${telescope_results}" },
        TelescopeSelection = { bg = "${telescope_prompt}" },
    },
    plugins = {
        all = true,
    },
})

onedark.load()
