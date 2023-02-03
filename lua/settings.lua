----------------------------------------------------------------------
--         load wezterm's custom config, if use my wezterm          --
--                  config, which is very personel                  --
----------------------------------------------------------------------

local local_conf_file = vim.fn.expand(string.format("~/.config/wezterm/custom.lua"))
local custom_wezconfig = {}
if vim.fn.filereadable(local_conf_file) == 1 then
    custom_wezconfig = dofile(local_conf_file)
end

----------------------------------------------------------------------
--                       Generating settings                        --
----------------------------------------------------------------------
local settings = {}
settings.theme = {
    color = "base16",
    base16_style = custom_wezconfig.color_scheme and custom_wezconfig.color_scheme or "onedark",
    statusline = {
        theme = "base16",
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
