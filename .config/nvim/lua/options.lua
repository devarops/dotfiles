local options = {
    colorcolumn = "100",
    completeopt = { "menu", "menuone", "noselect" },
    expandtab = true,
    hidden = true,
    hlsearch = true,
    incsearch = true,
    list = true,
    listchars = { tab = "»·", extends = ">", precedes = "<", trail = "·" },
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    scrolloff = 10,
    shiftwidth = 4,
    showmode = false,
    showtabline = 2,
    signcolumn = "yes",
    smartcase = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true, -- set terminal GUI colors
    textwidth = 100,
    wrap = false,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

vim.opt["formatoptions"]:remove("t") -- Do not auto-wrap text using textwidth
vim.opt["iskeyword"]:append("-") -- Define compound words separated with hyphen as a single word
