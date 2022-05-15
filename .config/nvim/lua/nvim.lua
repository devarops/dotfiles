local options = {
  number = true,            -- set numbered lines
  relativenumber = true,    -- set relative numbered lines
  termguicolors = true,     -- set terminal GUI colors
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt["iskeyword"]:append("-")
