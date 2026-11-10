local os_utils         = require("utils.os")
local is_none_filetype = require("utils.filetype").is_nonefiletype
local os_path          = require("utils.os.path")
local uv               = vim.uv or vim.loop

local M                = {}

local function sudo_write(filepath)
    if filepath == "" then
        vim.notify("E32: No file name", vim.log.levels.ERROR)
        return
    end
    -- Save buffer to a temporary file
    local tmpfile = vim.fn.tempname()
    vim.cmd.write({ args = { tmpfile }, bang = true })
    -- Prompt for password
    require("utils.input").secret("Please input password: ", function(password)
        if password == nil or password == "" then
            vim.notify("Invalid password, sudo aborted", vim.log.levels.WARN)
            vim.fn.delete(tmpfile)
            return
        end
        -- Use sudo to move the file.
        -- NOTE: never pass the password through "sh -c" (Lua's %q is NOT
        -- shell quoting: $, `...` and $(...) would be expanded/executed).
        -- Feed it via stdin instead.
        local proc = vim.system({
            "sudo", "-p", "", "-S",
            "dd", "if=" .. tmpfile, "of=" .. filepath, "bs=1048576",
        }, { stdin = password .. "\n" }):wait()
        -- Handle result
        if proc.code == 0 then
            vim.bo.modified = false
            vim.cmd.checktime()
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true
            )
        else
            vim.notify(proc.stderr, vim.log.levels.ERROR)
        end

        vim.fn.delete(tmpfile)
    end)
end

function M.save_file()
    local filename = vim.fn.expand("%:p")

    if is_none_filetype() then
        return
    end

    -- nothing to do when the buffer has no unsaved changes
    if not vim.bo.modified then
        return
    end

    -- if blink's menu is on, close it
    if package.loaded["blink.cmp"] then
        local cmp = require("blink.cmp")
        if cmp.is_menu_visible() then
            cmp.cancel()
        end
    end

    -- only if file exist, and now owned by current user, save it with sudo, only on linux and mac.
    -- Owner check uses libuv stat, no shell involved (filenames with
    -- $/`/$( ) must not be passed to io.popen or sh -c).
    if filename ~= "" and os_utils.name() ~= "windows" then
        local fpath_name = os_path.exists(filename) and filename or os_path.dirname(filename)

        local stat = uv.fs_stat(fpath_name)
        if stat and stat.uid ~= uv.getuid() then
            sudo_write(filename)
            return
        end
    end

    -- if an new buffer, ask for saving name
    -- local filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
        filename = vim.fn.input("Save As: ")
        if vim.trim(filename) == "" then
            vim.notify("filename can not be empty", vim.log.levels.ERROR)
            return
        end
    end

    vim.cmd.write({ args = { filename }, magic = { file = false } })
    vim.cmd("stopinsert")
end

return M
