local colors = {
  vertsplit      = '#181A1F',
  special_grey   = '#3B4048',
  menu_grey      = '#3E4452',
  cursor_grey    = '#2C323C',
  gutter_fg_grey = '#4B5263',
  blue           = '#82b1ff',
  dark_red       = '#BE5046',
  white          = '#bfc7d5',
  green          = '#C3E88D',
  purple         = '#c792ea',
  yellow         = '#ffcb6b',
  light_red      = '#ff869a',
  red            = '#ff5370',
  dark_yellow    = '#F78C6C',
  cyan           = '#89DDFF',
  comment_grey   = '#697098',
  black          = '#292D3E',
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    theme  = 'palenight',
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 2,
          buffers_color = {
            active = { fg = colors.black, bg = colors.green, gui = 'bold' },
            inactive = { fg = colors.green, bg = colors.menu_grey },
          },
        },
      },
    },
  },
}
