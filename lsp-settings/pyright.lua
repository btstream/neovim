local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
local config = {}
local root = find_pyproject_toml(vim.fn.expand("%:p") or vim.fn.getcwd())
if root and vim.fn.executable("poetry") == 1 then
    local path = vim.fn.system({ "poetry", "env", "info", "--path" })
    config["python.venvPath"] = path
end
config["python.analysis.stubPath"] = vim.fn.stdpath("data") .. "/lazy/python-type-stubs"
return config
