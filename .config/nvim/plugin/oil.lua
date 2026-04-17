vim.pack.add({
  -- Optional icon providers used by oil.nvim
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/nvim-tree/nvim-web-devicons',

  -- Main plugin: filesystem-as-buffer file explorer
  'https://github.com/stevearc/oil.nvim',
})

require('mini.icons').setup()
require('oil').setup()
