local options = {
  colorcolumn = "100",
  expandtab = true,
  hidden = true,
  hlsearch = true,
  incsearch = true,
  number = true,            -- set numbered lines
  relativenumber = true,    -- set relative numbered lines
  scrolloff = 10,
  shiftwidth = 4,
  showmode = false,
  showtabline = 2,
  signcolumn = "yes",
  smartcase = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,     -- set terminal GUI colors
  textwidth = 100,
  wrap = false,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt["iskeyword"]:append("-")
vim.opt["formatoptions"]:remove("t")

