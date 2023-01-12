-- require("utils.packer").ensure_loaded("nvim-ts-rainbow")
require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = { enable = true },
    rainbow = { enable = true },
})
