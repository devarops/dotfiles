return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 2,
          buffers_color = {
            active = { fg = 'green', bg = 'colour238'},
            inactive = { fg = 'colour238', bg = 'green' },
          },
        },
      },
    },
  },
}
