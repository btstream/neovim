return {
    "rebelot/heirline.nvim",
    event = "User LazyVimStarted",
    opts = function()
        return {
            statusline = {
                hl = { bg = "gray" },
                require("plugins.heirline.components.mode"),
                require("plugins.heirline.components.ssh"),
                -- require("plugins.heirline.components.fileindicator"),
                require("plugins.heirline.components.path"),
                require("plugins.heirline.components.git"),
                require("plugins.heirline.components.diagnostics"),
                require("plugins.heirline.components.fill"),
                -- require("plugins.heirline.components.ssh_center"),
                -- require("plugins.heirline.components.fill"),
                require("plugins.heirline.components.fileformat"),
                require("plugins.heirline.components.lspservers"),
                require("plugins.heirline.components.plugins"),
                require("plugins.heirline.components.codecompanion"),
                require("plugins.heirline.components.location"),
            },
        }
    end,
    config = function(_, opts)
        local get_heirline_color = require("themes.heirline").get_heirline_color
        opts = vim.tbl_extend("keep", opts, {
            opts = { colors = get_heirline_color() },
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                require("heirline.utils").on_colorscheme(get_heirline_color)
            end,
        })
        require("heirline").setup(opts)
    end,
}
