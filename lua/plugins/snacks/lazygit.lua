return {
    config = {
        gui = {
            nerdFontsVersion = "3",
        },
    },
    -- Theme for lazygit
    theme = {
        [241]                      = { fg = "Special" },
        activeBorderColor          = { fg = "LazygitActiveBorderColor", bold = true },
        cherryPickedCommitBgColor  = { fg = "LazygitCherryPickedCommitBgColor" },
        cherryPickedCommitFgColor  = { fg = "LazygitCherryPickedCommitFgColor" },
        defaultFgColor             = { fg = "LazygitDefaultFgColor" },
        inactiveBorderColor        = { fg = "LazygitInactiveBorderColor" },
        optionsTextColor           = { fg = "LazygitOptionsTextColor" },
        searchingActiveBorderColor = { fg = "LazygitSearchingActiveBorderColor", bold = true },
        selectedLineBgColor        = { bg = "LazygitSelectedLineBgColor" }, -- set to `default` to have no background colour
        unstagedChangesColor       = { fg = "LazygitUnstagedChangesColor" },
    },
    win = {
        style = "lazygit",
        on_close = function()
            require("neo-tree.events").fire_event("git_event")
        end
    },
}
