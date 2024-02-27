local heirline = require("heirline")
local statusline = {
    hl = function()
        return {
            bg = require("plugins.heirline.util").get_color("gray"),
        }
    end,
    require("plugins.heirline.components.mode"),
    require("plugins.heirline.components.fileindicator"),
    require("plugins.heirline.components.fill"),
    require("plugins.heirline.components.lspservers"),
    require("plugins.heirline.components.location"),
}
heirline.setup({
    statusline = statusline,
})
