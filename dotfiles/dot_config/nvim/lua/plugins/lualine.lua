local gps = require 'nvim-gps'
local bo = vim.bo
local fn = vim.fn

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = 'tokyonight',
  },
  sections = {
    lualine_c = {
      'filename',
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
    },
  },
}
