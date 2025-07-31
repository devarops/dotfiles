-- Tree-sitter is a parser generator tool and an incremental parsing library.
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  ensure_installed = {
    "bash",
    "dockerfile",
    "gnuplot",
    "lua",
    "make",
    "python",
    "r",
  },
  sync_install = true,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true, },
  textobjects = { enable = true },
}
