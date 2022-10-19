----------------------------------------------------------------------
--                     set keymaps for plugins                      --
--          in order to make plugins do lazy load for cmd           --
----------------------------------------------------------------------
local Path = require("plenary.path")
local plugins_keymaps = Path:new(vim.fn.stdpath("config"), "lua", "keymaps", "plugins", "*")
for _, v in ipairs(vim.split(vim.fn.glob(plugins_keymaps:absolute()), "\n")) do
    local module = (vim.split(vim.fs.basename(v), ".lua"))[1]
    if module ~= "init" then
        pcall(require, "keymaps.plugins." .. module)
    end
end
