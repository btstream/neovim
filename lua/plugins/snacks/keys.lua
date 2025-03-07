return {
    { mode = { "n" },      "<Leader>fh", function() Snacks.picker.recent() end,                 desc = "Open file history" },
    { mode = { "n" },      "<Leader>ff", function() Snacks.picker.files() end,                  desc = "Find files in cwd" },
    { mode = { "n" },      "<Leader>ss", "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua", desc = "Open Settings" },
    { mode = { "n", "i" }, "<C-k>p",     function() Snacks.picker.files() end,                  desc = "find file" },
    {
        mode = { "n", "i" },
        "<C-k><C-p>",
        function()
            Snacks.picker()
        end,
        desc = "Open all pickers"
    },
    {
        mode = { "n", "i" },
        "<C-k>s",
        function()
            Snacks.picker
                .lsp_symbols()
        end,
        desc = "show document symboles"
    },
    {
        mode = { "n", "i" },
        "<C-k>S",
        function()
            Snacks.pickers
                .lsp_workspace_symbols()
        end,
        desc = "show workspace symboles"
    },

    {
        mode = { "n", "i" },
        "<C-k>r",
        function()
            Snacks.picker
                .resume()
        end,
        desc = "Resume"
    },
    {
        mode = { "n", "i" },
        "<C-b>",
        function()
            Snacks.picker
                .buffers()
        end,
        desc = "List all openned buffers"
    },

    { "gd",         function() Snacks.picker.lsp_definitions({ prompt = " > " }) end,      desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations({ prompt = " > " }) end,     desc = "Goto Declaration" },
    { "gr",         function() Snacks.picker.lsp_references({ prompt = " > " }) end,       nowait = true,                        desc = "References" },
    { "gI",         function() Snacks.picker.lsp_implementations({ prompt = " > " }) end,  desc = "Goto Implementation" },
    { "gy",         function() Snacks.picker.lsp_type_definitions({ prompt = " > " }) end, desc = "Goto T[y]pe Definition" },

    { "<leader>xX", function() Snacks.picker.diagnostics({ prompt = " > " }) end,          desc = "Get Diagnostics of Workspace" },
    { "<leader>xx", function() Snacks.picker.diagnostics_buffer({ prompt = " > " }) end,   desc = "Get diagnostics of buffer" }
}
