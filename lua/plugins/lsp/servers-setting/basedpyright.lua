local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
local path = require("utils.os.path")
local config = {
    -- stylua: ignore start
    ["basedpyright.analysis.typeCheckingMode"]            = "standard",
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
        ["reportAttributeAccessIssue"]                    = "information",
    },
    -- stylua: ignore end
}
local stub_path = path.join(vim.fn.stdpath("data"), "lazy", "python-type-stubs", "stubs")
if path.exists(stub_path) then
    config["basedpyright.analysis.stubPath"] = stub_path
end

local root = find_pyproject_toml(vim.fn.expand("%:p") or vim.fn.getcwd())
if root and vim.fn.executable("poetry") == 1 then
    local path = vim.fn.system({ "poetry", "env", "info", "--path" })
    config["python.venvPath"] = path
end
return config
