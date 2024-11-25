local stylua = require("efmls-configs.formatters.stylua")

local find_stylua_config = require("lspconfig.util").root_pattern("stylua.toml", ".stylua.toml")
local path = find_stylua_config(vim.fn.expand("%:p") or vim.fn.getcwd()) or vim.fn.getcwd()
for _, value in pairs({ "stylua.toml", ".stylua.toml" }) do
    local configfile = vim.fn.expand(string.format("%s/%s", path, value))
    if vim.fn.glob(configfile) ~= "" then
        stylua.formatCommand = stylua.formatCommand .. " -f " .. configfile
        return stylua
    end
end
stylua.formatCommand = stylua.formatCommand .. " --indent-type Spaces --indent-width 4 "
return stylua
