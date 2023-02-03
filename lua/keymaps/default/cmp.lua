return {
    { { "i", "s" }, "<C-j>", "vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)' : '<C-j>'", { expr = true } },
    { { "i", "s" }, "<C-S-j>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-S-j>'", { expr = true } },
    { { "i", "s" }, "<Tab>", "vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)' : '<Tab>'", { expr = true } },
    { { "i", "s" }, "<S-Tab>", "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<S-j>'", { expr = true } },
}
