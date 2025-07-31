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
            active = { fg = '#30302c', bg = '#99ad6a', gui = 'bold' },
            inactive = { fg = '#e8e8d3', bg = '#4e4e43' },
          },
        },
      },
    },
  },
}
