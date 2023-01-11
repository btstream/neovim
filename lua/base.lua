local opt = vim.opt

----------------------------------------------------------------------
--                                ui                                --
----------------------------------------------------------------------
opt.cursorline = true
opt.signcolumn = "yes"
opt.number = true
opt.laststatus = 3
opt.fillchars = {
    -- winframes to use heavy separator
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    -- disable eob
    eob = " ",
}
opt.list = true
opt.listchars = {
    lead = "",
    space = "",
    tab = "  ",
}
opt.termguicolors = true

----------------------------------------------------------------------
--                              indent                              --
----------------------------------------------------------------------
opt.autoindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.wrap = false

----------------------------------------------------------------------
--                              mouse                               --
----------------------------------------------------------------------
opt.mouse = opt.mouse + "a"

----------------------------------------------------------------------
--                            clipboard                             --
----------------------------------------------------------------------
opt.clipboard = "unnamedplus"

----------------------------------------------------------------------
--                           fileformats                            --
----------------------------------------------------------------------
opt.fileformats = "unix,dos"
opt.showmatch = true

----------------------------------------------------------------------
--                           performance                            --
----------------------------------------------------------------------
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100

----------------------------------------------------------------------
--                               fold                               --
----------------------------------------------------------------------
opt.foldcolumn = "0"

function _G.Test(...)
    print(vim.inspect(arg))
end

opt.statuscolumn =
    ' %=%l %s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " " }%* '

-- disable statuscolumn for none file types
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("ClearStatusColumn", { clear = true }),
    callback = function()
        local filetype_tools = require("plugins.settings.lualine.utils.filetype_tools")
        if filetype_tools.is_nonefiletype() then
            vim.opt_local.statuscolumn = ""
        end
    end,
})
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "Outline",
--     callback = function()
--         vim.opt_local.statuscolumn = ""
--     end,
-- })

opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99
-- opt.foldtext = "v:lua.custom_fold_text()"

----------------------------------------------------------------------
--                              search                              --
----------------------------------------------------------------------
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

----------------------------------------------------------------------
--                           Spell Check                            --
----------------------------------------------------------------------
vim.opt_local.spelloptions:append("noplainbuffer")
opt.spell = false

----------------------------------------------------------------------
--                            behavious                             --
----------------------------------------------------------------------
opt.splitright = true
opt.autoread = true
-- auto commands to reload buffer
vim.cmd([[
augroup reladbuffer
    au!
    au CursorHold,CursorHoldI * checktime
    au FocusGained,BufEnter * :checktime
augroup end
]])

----------------------------------------------------------------------
--                               keys                               --
----------------------------------------------------------------------
-- set leader char to space
vim.g.mapleader = " "
