local opt = vim.opt
----------------------------------------------------------------------
--                                ui                                --
----------------------------------------------------------------------
opt.cursorline = true
opt.signcolumn = "yes"
opt.number = true
opt.laststatus = 3
local fillchars = {
    eob = " ",
}
if os.getenv("TERM_PROGRAM") ~= "WezTerm" then
    fillchars = {
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
end
opt.fillchars = fillchars
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
--                           titlestring                            --
----------------------------------------------------------------------
opt.title = true
opt.titlestring = [[%f %h%m%r%w]]

----------------------------------------------------------------------
--                            behavious                             --
----------------------------------------------------------------------
opt.splitright = true
opt.autoread = true
-- auto commands to reload buffer
-- vim.cmd([[
-- augroup reladbuffer
--     au!
--     au CursorHold,CursorHoldI * checktime
--     au FocusGained,BufEnter * :checktime
-- augroup end
-- ]])
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained", "BufEnter" }, {
    pattern = "*",
    callback = function()
        local bufnr = tonumber(vim.fn.expand("<abuf>"))
        local name = vim.api.nvim_buf_get_name(bufnr)
        if
            name == ""
            -- Only check for normal files
            or vim.bo[bufnr].buftype ~= ""
            -- To avoid: E211: File "..." no longer available
            or not vim.fn.filereadable(name)
        then
            return
        end
        -- only check for the current buffer
        vim.cmd(bufnr .. "checktime")
    end,
})

----------------------------------------------------------------------
--                               keys                               --
----------------------------------------------------------------------
-- set leader char to space
vim.g.mapleader = " "
