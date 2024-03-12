return {
    ["rust-analyzer"] = {
        imports = {
            prefix = "self",
            granularity = {
                group = "module",
            },
        },
        completion = {
            autoimport = { enable = true },
        },
    },
}
