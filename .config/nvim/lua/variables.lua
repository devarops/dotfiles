local variables = {
    gruvbox_contrast_light = "hard",
    mapleader = " ",
    netrw_banner = 0,
    netrw_liststyle = 3,
    R_assign = 2,
}

for key, value in pairs(variables) do
    vim.g[key] = value
end
