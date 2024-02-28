return {
    "dstein64/nvim-scrollview",
    opts = {
        excluded_filetypes = require("utils.filetype").get_nonfiletypes(),
        current_only = true,
        -- base = "right",
        -- column = 80,
        signs_on_startup = {},
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
    },
}
