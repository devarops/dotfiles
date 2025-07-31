return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 2,
        },
      },
    },
  },
}
