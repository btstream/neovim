local highlight = require("themes.utils").highlight
-- local darken = require("themes.utils").darken

local M = {}

local function apply_hl()
    highlight(require("themes.base16.highlights").hg())
end

local function setup_autocmds()
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

    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        pattern = "*",
        callback = function()
            local colors = require("themes.base16.colors").colors()
            -- local dbg = darken(colors.base00, 0.15)
            if vim.bo.filetype == "NvimTree" or vim.bo.filetype == "neo-tree" then
                highlight({
                    NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base0D },
                    OutlineSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                    NeoTreeTabActive = { bg = colors.base00, fg = colors.base0D },
                })
            elseif vim.bo.filetype == "Outline" then
                highlight({
                    NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                    OutlineSidebarTitle = { bg = colors.base00, fg = colors.base0D },
                    NeoTreeTabActive = { bg = colors.base00, fg = colors.base03 },
                })
            else
                highlight({
                    NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                    OutlineSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                    NeoTreeTabActive = { bg = colors.base00, fg = colors.base03 },
                })
            end
        end,
    })
end

function M.setup()
    local colors = require("themes.base16.colors").colors()
    require("base16-colorscheme").setup(colors)

    apply_hl()
    setup_autocmds()
end

M.setup()
return M
