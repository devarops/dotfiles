local variables = {
    mapleader = " ",
    netrw_banner = 0,
    netrw_liststyle = 3,
    R_assign = 2,
    sentencer_textwidth = -1,
}

for key, value in pairs(variables) do
    vim.g[key] = value
end
