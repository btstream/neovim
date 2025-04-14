return {
    static = {
        processing = false,
    },
    update = {
        "User",
        pattern = "CodeCompanionRequest*",
        callback = function(self, args)
            if args.match == "CodeCompanionRequestStarted" then
                self.processing = true
            elseif args.match == "CodeCompanionRequestFinished" then
                self.processing = false
            end
            vim.cmd("redrawstatus")
        end,
    },
    {
        condition = function(self)
            return self.processing
        end,
        provider = "  ",
        hl = { fg = "yellow", bg = "grey" },
    },
}
