-- Tree-sitter is a parser generator tool and an incremental parsing library.
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    auto_install = true,
    ensure_installed = {
      'bash',
      'diff',
      'dockerfile',
      'gnuplot',
      'html',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'r',
      'vim',
      'vimdoc',
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = true, },
    sync_install = true,
    textobjects = { enable = true },
  },
}
