local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "folke/which-key.nvim",              -- Display available keybindings
  "github/copilot.vim",                -- AI code completion
  "gruvbox-community/gruvbox",         -- Gruvbox colorscheme
  "mbbill/undotree",                   -- Persistent undo history
  "navarasu/onedark.nvim",             -- Theme inspired by Atom
  "nvim-lua/plenary.nvim",             -- Dependencie of nvim-telescope/telescope.nvim
  "nvim-lualine/lualine.nvim",         -- Statusline for Neovim
  "nvim-telescope/telescope.nvim",     -- Fuzzy finder for Neovim
  "nvim-treesitter/nvim-treesitter",   -- Treesitter support for Neovim
  "saghen/blink.cmp",                  -- Blink.nvim completion source for Neovim
  "tpope/vim-fugitive",                -- Git integration for Neovim
  "whonore/vim-sentencer",             -- One sentence per line and wrap long lines
})

require("plugins.blink")
require("plugins.copilot")
require("plugins.lualine")
require("plugins.sentencer")
require("plugins.treesitter")
require("plugins.which-key")
