local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
local config = {}
local root = find_pyproject_toml(vim.fn.expand("%:p") or vim.fn.getcwd())
print(root)
if root then
    local path = vim.fn.system({ "poetry", "env", "info", "--path" })
    config["python.venvPath"] = path
end
return config
