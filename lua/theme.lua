local theme = require("settings").theme
require("themes." .. theme.color)
if theme.transparent then
    require("themes.transparent")
end
