local opt = vim.opt

opt.foldcolumn = "0"
opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99

function _G.on_fold_sign_click(_, click, button)
    if click == 1 and button == "l" then
        -- save current cursor position
        local oldpos = vim.fn.getcurpos()

        -- move cursor to current line of mouse and fold current fold
        local lnum = vim.fn.getmousepos().line

        if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
            local bufnum = vim.api.nvim_get_current_buf()
            local newpos = { bufnum, lnum, 0, 0 }
            vim.fn.setpos(".", newpos)
            vim.cmd("norm! za")

            -- move cursor back
            vim.fn.setpos(".", oldpos)
        end
    end
end

opt.statuscolumn = " %=%l %s"
    .. "%#FoldColumn#%@v:lua.on_fold_sign_click@%{"
    .. "foldlevel(v:lnum) > foldlevel(v:lnum - 1) "
    .. '? (foldclosed(v:lnum) == -1 ? "" : "") : " " '
    .. "}%T%* "

-- disable statuscolumn for none file types
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    pattern = "*",
    group = vim.api.nvim_create_augroup("ClearStatusColumn", { clear = true }),
    callback = function()
        local filetype_tools = require("utils.filetype_tools")
        if filetype_tools.is_nonefiletype() then
            if vim.bo.filetype == "spectre_panel" then
                vim.opt_local.statuscolumn = "   "
                vim.opt_local.number = false
            elseif vim.bo.filetype == "toggleterm" then
                vim.opt_local.statuscolumn = " "
            else
                vim.opt_local.statuscolumn = ""
            end
        end
    end,
})
