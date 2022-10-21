local highlight = require("themes.utils").highlight

local M = {}

local function apply_hl()
    highlight(require("themes.base16.highlights").hg())
end

function M.setup()
    local colors = require("themes.base16.colors").colors()
    require("base16-colorscheme").setup(colors)

    apply_hl()

    ----------------------------------------------------------------------
    --                        setup autocommands                        --
    ----------------------------------------------------------------------
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            apply_hl()
        end,
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "Outline",
        callback = function()
            local opts = "Normal:OutlineNormal,"
                .. "NormalNC:OutlineNormal,"
                .. "EndOfBuffer:OutlineEndOfBuffer,"
                .. "SignColumn:OutlineNormal,"
                .. "LineNr:OutlineLineNr,"
                .. "VertSplit:OutlineWinSeparator,"
                .. "WinSeparator:OutlineWinSeparator,"
            vim.wo.list = false
            vim.cmd("setlocal winhighlight=" .. opts)
        end,
    })
end

M.setup()
return M
