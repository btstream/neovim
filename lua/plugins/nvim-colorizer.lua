return {
    "catgoose/nvim-colorizer.lua",
    event = "User BufReadRealFile",
    opts = {
        "*",
        "!packer",
        "!snacks_terminal"
    },
}
