return {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
    opts = function()
        return {
            statusline = {
                hl = function()
                    return {
                        bg = require("themes.colors.manager").get_named_color("gray"),
                    }
                end,
                require("plugins.heirline.components.mode"),
                require("plugins.heirline.components.fileindicator"),
                require("plugins.heirline.components.git"),
                require("plugins.heirline.components.diagnostics"),
                require("plugins.heirline.components.fill"),
                require("plugins.heirline.components.fileformat"),
                require("plugins.heirline.components.lspservers"),
                require("plugins.heirline.components.location"),
            },
        }
    end,
}
