return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-k>t]],
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            hidden = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            on_open = function(terminal)
                -- set nvim tree
                -- if packer_plugins["nvim-tree.lua"].loaded then
                local nvimtree = require("nvim-tree")
                local nvimtree_view = require("nvim-tree.view")
                if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
                    local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
                    nvimtree.toggle()
                    nvimtree_view.View.width = nvimtree_width
                    nvimtree.toggle(false, true)
                end
                -- end

                local find_pyproject_toml = require("lspconfig.util").root_pattern("pyproject.toml")
                -- enter poetry virtual env
                local path = find_pyproject_toml(vim.fn.getcwd())
                if path then
                    terminal:send("poetry shell -q && exit")
                end

                -- quirk to disable highlight of sidebars
                vim.cmd("doautocmd BufEnter")
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
        })

        -- set keymap
        vim.keymap.set("n", "<C-k>g", function()
            lazygit:toggle()
        end, { desc = "open lazygit" })
        vim.keymap.set("t", "<C-w>k", function()
            vim.cmd("wincmd k")
        end)

        -- ensure enter insert mode when terminal gained focus
        vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
            callback = function()
                if vim.bo.filetype:upper() == "TOGGLETERM" then
                    vim.cmd("startinsert")
                end
            end,
        })
        -- require("plugins.settings.terminal")
    end,
    keys = { "<C-k>t", "<C-k>g" },
}
