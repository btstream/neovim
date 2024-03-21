return {
    Lua = {
        format = { enable = false },
        diagnostics = { globals = { "vim" }, disable = { "unused-vararg" } },
        workspace = { checkThirdParty = false, maxPreload = 1000 },
        hint = { enable = true, setType = true },
    },
}
