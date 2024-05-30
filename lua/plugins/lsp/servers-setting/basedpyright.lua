local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
local path = require("utils.os.path")
local stub_path = path.join(vim.fn.stdpath("data"), "lazy", "python-type-stubs", "stubs")
local config = {
    -- stylua: ignore start
    ["basedpyright.analysis.typeCheckingMode"]            = "all",
    ["basedpyright.analysis.useLibraryCodeForTypes"]      = true,
    ["basedpyright.analysis.diagnosticMode"]              = "workspace",
    ["basedpyright.analysis.diagnosticSeverityOverrides"] = {
        ["reportUnknownVariableType"]                     = "information",
        ["reportUnknownMemberType"]                       = "information",
        ["reportUnknownParameterType"]                    = "information",
        ["reportUnknownLambdaType"]                       = "information",
        ["reportUnknownArgumentType"]                     = "information",
        ["reportFunctionMemberAccess"]                    = "information",
        ["reportOptionalMemberAccess"]                    = "information",
    },
    -- stylua: ignore end
}
if path.exists(stub_path) then
    config["basedpyright.analysis.stubPath"] = stub_path
end

local root = find_pyproject_toml(vim.fn.expand("%:p") or vim.fn.getcwd())
if root and vim.fn.executable("poetry") == 1 then
    local path = vim.fn.system({ "poetry", "env", "info", "--path" })
    config["python.venvPath"] = path
end
return config
