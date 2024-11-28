local yapf = require("efmls-configs.formatters.yapf")
local stylua = require("plugins.lsp.providers.efm.stylua")
local xmlformat = require("plugins.lsp.providers.efm.xmlformat")
local languages = {
    lua = { stylua },
    python = { yapf },
    xml = { xmlformat },
}

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
require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
    on_attach = require("plugins.lsp.utils").on_attach,
}))
