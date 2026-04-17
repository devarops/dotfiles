vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

require('lualine').setup({
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
})
