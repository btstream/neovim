return {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...

    keys = {
        {
            mode = { "n", "i" },
            "<c-k>h",
            function()
                local grug_far = require("grug-far")
                local has_inst, inst = pcall(grug_far.get_instance)
                if has_inst then
                    inst:open()
                else
                    inst = grug_far.open()
                end
                inst:when_ready(function()
                    require("utils.window").close_others()
                end)
            end,
            desc = "Find and replace in workspace"
        },
        {
            mode = { "n", "i" },
            "<c-k>H",
            function()
                local grug_far = require("grug-far")
                local has_inst, inst = pcall(grug_far.get_instance)
                if has_inst then
                    inst:update_input_values({ search = vim.fn.expand("<cword>") }, true)
                    inst:open()
                else
                    inst = grug_far.open({ prefills = { search = vim.fn.expand("<cword>") } })
                end
                inst:when_ready(function()
                    require("utils.window").close_others()
                end)
            end,
            desc = "Find and replace in workspace"
        }
    },

    cmd = { "GrugFar", "GrugFarWith" },
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            staticTitle = "Find and Search"
        });
    end
}
