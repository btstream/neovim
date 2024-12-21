local yapf = require("efmls-configs.formatters.yapf")
local stylua = require("plugins.lsp.servers.efm.formatter.stylua")
local xmlformat = require("plugins.lsp.servers.efm.formatter.xmlformat")
local prettierd = require("plugins.lsp.servers.efm.formatter.prettierd")

local languages = {
    python = { yapf },
    xml = { xmlformat },
    json = { prettierd },
    jsonc = { prettierd }
}

-- only use stylua to format if stylua is set in project' dir
if stylua ~= true then
    languages.lua = { stylua }
end

local default_root_pattern = {
    -- custom pattern
    ".nvim",
    ".neovim",

    -- git
    ".git",

    -- for CMake managed projects
    "CMakeLists.txt",

    -- for python
    "setup.py",
    "tox.ini",
    "requirements.txt",
    "Pipfile",
    "pyproject.toml",
}
local efmls_config = {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = default_root_pattern,
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
}
-- return vim.tbl_extend("force", efmls_config, {
--     on_attach = require("plugins.lsp.utils").on_attach,
-- })

return efmls_config
