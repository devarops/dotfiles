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
            active = { fg = '#444444', bg = '#98C379' },
            inactive = { fg = '#98C379', bg = '#444444' },
          },
        },
      },
    },
  },
}
