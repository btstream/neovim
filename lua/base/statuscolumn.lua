local opt = vim.opt
opt.foldcolumn = "0"
opt.foldnestmax = 0
opt.foldlevel = 99
opt.foldenable = true
opt.foldlevelstart = 99

if vim.fn.has("nvim-0.9") == 1 then
    local ffi = require("ffi")
    ffi.cdef([[
        typedef struct {} Error;
        typedef struct {} win_T;
        typedef struct {
            int start;  // line number where deepest fold starts
            int level;  // fold level, when zero other fields are N/A
            int llevel; // lowest level that starts in v:lnum
            int lines;  // number of lines from v:lnum to end of closed fold
        } foldinfo_T;
        foldinfo_T fold_info(win_T* wp, int lnum);
        win_T *find_window_by_handle(int Window, Error *err);
        int compute_foldcolumn(win_T *wp, int col);
        int win_col_off(win_T *wp);
    ]])

    function _G.get_foldsign()
        local wp = ffi.C.find_window_by_handle(0, ffi.new("Error"))
        local fold_info = ffi.C.fold_info(wp, vim.v.lnum)

        if fold_info.start == 0 then
            return " "
        elseif fold_info.start == vim.v.lnum then -- if this line is the start of a fold
            local currentline = vim.fn.getcurpos()[2]
            local current_fold_info = ffi.C.fold_info(wp, currentline)

            if fold_info.lines > 0 then
                return ""
            end

            if current_fold_info.start == fold_info.start then
                if fold_info.lines > 0 then
                    return ""
                end
                return ""
            else
                return " "
            end
        else
            return " "
        end
    end

    function _G.on_fold_sign_click(_, click, button)
        if click == 1 and button == "l" then
            -- save current cursor position
            local oldpos = vim.fn.getcurpos()

            -- move cursor to current line of mouse and fold current fold
            local lnum = vim.fn.getmousepos().line

            local wp = ffi.C.find_window_by_handle(0, ffi.new("Error"))
            local fold_info = ffi.C.fold_info(wp, lnum)

            if fold_info.start == lnum then
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
        .. "%#FoldColumn#%@v:lua.on_fold_sign_click@%{%"
        .. "v:lua.get_foldsign()"
        .. "%}%T%* "

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
                elseif vim.bo.filetype == "noice" then
                    vim.opt_local.statuscolumn = ""
                    vim.opt_local.number = false
                else
                    vim.opt_local.statuscolumn = ""
                end
            end
        end,
    })
end
