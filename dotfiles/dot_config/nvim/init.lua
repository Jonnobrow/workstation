function P(...)
  local args = { n = select('#', ...), ... }
  for i = 1, args.n do
    args[i] = vim.inspect(args[i])
  end
  print(unpack(args))
end

if not pcall(require, 'impatient') then
  print 'Failed to load impatient.'
end

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
vim.g.nvcode_termcolors = 256
vim.g.mapleader = ' '
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

require 'jonnobrow.plugins'
