local os_utils         = require("utils.os")
local is_none_filetype = require("utils.filetype").is_nonefiletype
local os_path          = require("utils.os.path")

local M                = {}
local function sudo_write(filepath)
    if filepath == "" then
        vim.notify("E32: No file name", vim.log.levels.ERROR)
        return
    end
    -- Save buffer to a temporary file
    local tmpfile = vim.fn.tempname()
    vim.cmd("write! " .. tmpfile)
    -- Prompt for password
    vim.fn.inputsave()
    local password = vim.fn.inputsecret("Password: ")
    vim.fn.inputrestore()
    if password == "" then
        vim.notify("Invalid password, sudo aborted", vim.log.levels.WARN)
        return
    end
    -- Use sudo to move the file
    local cmd = string.format("sudo -p '' -S dd if=%s of=%s bs=1048576",
        vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath)
    )
    local proc = vim.system({ "sh", "-c", string.format("echo %q | %s", password, cmd) }):wait()
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
end

function M.save_file()
    local filename = vim.fn.expand("%:p")

    if is_none_filetype() then
        return
    end

    -- if blink's menu is on, close it
    if package.loaded["blink.cmp"] then
        local cmp = require("blink.cmp")
        if cmp.is_menu_visible() then
            cmp.cancel()
        end
    end

    -- only if file exist, and now owned by current user, save it with sudo, only on linux and mac
    if filename ~= "" and os_utils.name() ~= "windows" then
        local forp_name = os_path.exists(filename) and filename or os_path.dirname(filename)

        local current_user = os.getenv("USER") or os.getenv("USER") or io.popen("id -un"):read("*l")
        local get_file_owner_cmd = os_utils.name() == "linux" and "stat -c %U " or "stat -f %Su "

        local f = io.popen(get_file_owner_cmd .. "\"" .. forp_name .. "\"")
        local owner = f:read("*l")

        if current_user ~= owner then
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

    vim.cmd("write " .. filename)
    vim.cmd("stopinsert")
end

return M
