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
            active = { fg = '#30302c', bg = '#99ad6a' },
            inactive = { fg = '#99ad6a', bg = '#4e4e43' },
          },
        },
      },
    },
  },
}
