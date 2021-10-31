local fn = vim.fn

require("utils")

-- load plugins
require("plugins/install")

-- load plugins settings
-- auto load configs
for i,j in pairs(fn.globpath(fn.stdpath('config')..'/lua/plugins/settings', '*.lua'):split('\n')) do
    local s = j:split("/")
    s = s[#s]:split(".")[1]
    print(s)
    require("plugins/settings/"..s)
end
