local di_api = require("dap-install.api.debuggers")
-- install python and codelldb
local debuggers = { 'python', 'codelldb' }

local installed_debuggers = di_api.get_installed_debuggers()
for _, d in pairs(debuggers) do
    local installed = false
    for _, i in pairs(installed_debuggers) do if d == i then installed = true end end
    if not installed then require('dap-install.main').main(0, d) end
end
