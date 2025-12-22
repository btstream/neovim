local set = vim.keymap.set
local is_none_filetype = require("utils.filetype").is_nonefiletype
local os_utils = require("utils.os")

function sudo_write(filepath)
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

local m = { "i", "n", "v" }
set({ "n", "i" }, "<C-s>", function()
    local filename = vim.fn.expand("%:p")

    if is_none_filetype() then
        return
    end

    if filename ~= "" and os_utils.name() ~= "windows" then
        local current_user = os.getenv("USER") or os.getenv("USER") or io.popen("id -un"):read("*l")
        local get_file_owner_cmd = os_utils.name() == "linux" and "stat -c %U " or "stat -f %Su"

        local f = io.popen(get_file_owner_cmd .. filename)
        local owner = f:read("*l")

        if current_user ~= owner then
            sudo_write(filename)
            return
        end
    end


    -- if not vim.api.nvim_get_option_value("modifiable", { buf = 0 }) then
    --     -- vim.notify("Buf is not modifiable", vim.log.levels.INFO)
    --     return
    -- end

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
end)
set("n", "<SPACEE>", "<Nop>")
set("i", "<S-Tab>", "<C-d>")
set("n", "<SPACEE>", "<Nop>")

set(m, "<C-n>", "<down>")
set(m, "<C-p>", "<up>")
set(m, "<C-f>", "<right>")
set(m, "<C-b>", "<left>")
set(m, "<C-a>", "<home>")
set(m, "<C-e>", "<end>")

-- clean search hilight
-- map("n", "<Esc><Esc>", "<cmd>nohl<cr>")

-- resize window
set("n", "<C-S-right>", "<cmd>vertical resize +1<cr>")
set("n", "<C-S-left>", "<cmd>vertical resize -1<cr>")
set("n", "<C-S-up>", "<cmd>resize +1<cr>")
set("n", "<C-S-down>", "<cmd>resize -1<cr>")

-- bufer
set("n", "bn", "<cmd>bnext<cr>", { desc = "goto next buffer" })
set("n", "bN", "<cmd>bprevious<cr>", { desc = "goto previous buffer" })
set("n", "bc", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>q", require("utils.window").quit, { desc = "close current buffer" })
set("n", "<leader>Q", require("utils.window").close_others, { desc = "close all other window" })

-- move lines
set("n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true })
set("n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true })
set("n", "<C-down>", "<cmd>m .+1<CR>==", { silent = true })
set("n", "<C-up>", "<cmd>m .-2<CR>==", { silent = true })

set("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
set("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })
set("i", "<C-down>", "<Esc><cmd>m .+1<CR>==gi", { silent = true })
set("i", "<C-up>", "<Esc><cmd>m .-2<CR>==gi", { silent = true })

set("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
set("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { silent = true })
set("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv", { silent = true })
set("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv", { silent = true })

set("t", "<C-w>w", "<cmd>wincmd w<cr>")
set("t", "<C-w>h", "<cmd>wincmd h<cr>")
set("t", "<C-w>i", "<cmd>wincmd i<cr>")
set("t", "<C-w>j", "<cmd>wincmd j<cr>")
set("t", "<C-w>k", "<cmd>wincmd k<cr>")
