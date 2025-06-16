local function go_to_terminal(index)
    return function()
        local terminals = require("toggleterm.terminal").get_all()
        local term = terminals[index]
        if index == -1 or not term then
            term = terminals[#terminals]
        end
        if term:is_open() then
            return
        else
            for _, t in pairs(terminals) do
                if t.id ~= term.id and t:is_open() then
                    t:toggle()
                end
            end
            term:toggle()
        end
    end
end

-- TODO:fix keymap
return {
    "akinsho/toggleterm.nvim",
    enabled = false,
    config = function(_, opts)
        require("toggleterm").setup(vim.tbl_extend("keep", opts, {
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 10
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-k>t]],
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            hide_numbers = true,    -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            hidden = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = function()
                if require("utils.os").name() == "windows" then
                    if vim.fn.executable("xonsh") == 1 then
                        return "xonsh"
                    end
                    if vim.fn.executable("pwsh") == 1 then
                        return "pwsh"
                    end
                    return "powershell"
                end
                return vim.o.shell
            end, -- change the default shell
            highlights = {
                StatusLine = { link = "StatusLine" },
            },
            on_create = function(terminal)
                local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
                -- enter poetry virtual env
                local path = find_pyproject_toml(vim.fn.getcwd())
                if path and vim.fn.executable("poetry") == 1 then
                    terminal:send("poetry shell -q && exit")
                end
            end,
            on_open = function(terminal)
                -- vim.cmd("doautocmd BufEnter")
                if not (vim.fn.has("win32") and vim.fn.executable("xonsh")) then
                    terminal:send("clear")
                end
                terminal:focus()

                local opts = { buffer = 0 }
                vim.keymap.set("t", "<C-w>h", [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set("t", "<C-w>j", [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set("t", "<C-w>k", [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set("t", "<C-w>l", [[<Cmd>wincmd l<CR>]], opts)

                for i = 1, 10, 1 do
                    vim.keymap.set("t", string.format("<A-%d>", i), go_to_terminal(i))
                end
            end,
        }))

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = { border = "double", highlights = { background = "TelescopeNormal" } },
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.cmd("setfiletype Lazygit")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
            on_close = function()
                require("neo-tree.events").fire_event("git_event")
            end,
        })

        -- set keymap
        vim.keymap.set("n", "<C-k>g", function()
            lazygit:toggle()
        end, { desc = "open lazygit" })

        -- ensure enter insert mode when terminal gained focus
        vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
            callback = function()
                if vim.bo.filetype == "toggleterm" then
                    vim.cmd("startinsert!")
                end
            end,
        })
    end,
    keys = { "<C-k>t", "<C-k>g" },
}
