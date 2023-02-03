-- TODO:fix keymap
return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
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
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            hidden = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            on_open = function(terminal)
                if vim.g.loaded_neo_tree == 1 then
                    local active_source = require("plugins.neo-tree.utils").get_active_source()
                    if active_source ~= nil and terminal.direction == "horizontal" then
                        require("plugins.neo-tree.utils").toggle(false)
                        require("plugins.neo-tree.utils").toggle(false)
                    end
                end

                local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
                -- enter poetry virtual env
                local path = find_pyproject_toml(vim.fn.getcwd())
                if path then
                    terminal:send("poetry shell -q && exit")
                end

                -- quirk to disable highlight of sidebars
                -- vim.cmd("doautocmd BufEnter")
                terminal:focus()

                -- local opts = { buffer = 0 }
                -- vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
                -- vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
                -- vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
                -- vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            end,
        })

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
                if vim.bo.filetype:upper() == "TOGGLETERM" then
                    vim.cmd("startinsert")
                end
            end,
        })
    end,
    keys = { "<C-k>t", "<C-k>g" },
}
