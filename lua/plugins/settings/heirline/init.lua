local heirline = require("heirline")
local statusline = {
    require("plugins.heirline.components.mode"),
    require("plugins.heirline.components.fill"),
    require("plugins.heirline.components.mode"),
}
heirline.setup({
    statusline = statusline,
})
