return {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
    -- config = function()
    --     local heirline = require("heirline")
    --     local statusline = {
    --         hl = function()
    --             return {
    --                 bg = require("plugins.heirline.util").get_color("gray"),
    --             }
    --         end,
    --         require("plugins.heirline.components.mode"),
    --         require("plugins.heirline.components.fileindicator"),
    --         require("plugins.heirline.components.git"),
    --         require("plugins.heirline.components.diagnostics"),
    --         require("plugins.heirline.components.fill"),
    --         require("plugins.heirline.components.fileformat"),
    --         require("plugins.heirline.components.lspservers"),
    --         require("plugins.heirline.components.location"),
    --     }
    --     heirline.setup({
    --         statusline = statusline,
    --     })
    -- end,
    opts = function()
        local heirline = require("heirline")
        return {
            statusline = {
                hl = function()
                    return {
                        bg = require("plugins.heirline.util").get_color("gray"),
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
