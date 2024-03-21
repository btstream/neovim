----------------------------------------------------------------------
--         load wezterm's custom config, if use my wezterm          --
--                  config, which is very personel                  --
----------------------------------------------------------------------

local custom_wezterm_config = vim.fn.expand(string.format("~/.config/wezterm/custom.lua"))
local custom_wezconfig = {}
if require("utils.os.path").exists(custom_wezterm_config) then
    custom_wezconfig = dofile(custom_wezterm_config)
end

----------------------------------------------------------------------
--                       Generating settings                        --
----------------------------------------------------------------------
local settings = {}
settings.theme = {
    color_scheme = custom_wezconfig.color_scheme and custom_wezconfig.color_scheme or "material-darker",
    statusline = {
        show_separators = true,
    },
}

return setmetatable({}, {
    __index = function(_, key)
        if key == "with" then
            return function(config)
                settings = vim.tbl_deep_extend("force", settings, config)
            end
        else
            return settings[key]
        end
    end,
})
