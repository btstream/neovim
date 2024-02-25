local heirline = require("heirline")
local statusline = {
    hl = "StatusLine",
    require("plugins.heirline.components.mode"),
    require("plugins.heirline.components.fileindicator"),
    require("plugins.heirline.components.fill"),
}
heirline.setup({
    statusline = statusline,
})
