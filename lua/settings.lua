local local_conf_file = vim.fn.expand(string.format("~/.config/wezterm/custom.lua"))
local custom_wezconfig = {}
if vim.fn.filereadable(local_conf_file) == 1 then
    custom_wezconfig = dofile(local_conf_file)
end

local settings = {}
settings.theme = {
    color = "base16",
    base16_style = custom_wezconfig.color_scheme and custom_wezconfig.color_scheme or "onedark",
    transparent = false,
    statusline = {
        theme = "base16",
    },
}
return settings
