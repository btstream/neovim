return {
    "norcalli/nvim-colorizer.lua",
    event = "User BufReadRealFile",
    config = function()
        require("colorizer").setup({
            "*",
            "!packer",
        })
    end,
}
