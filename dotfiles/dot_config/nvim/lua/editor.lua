local o = vim.o
local wo = vim.wo
local g = vim.g

vim.opt.shortmess:append 'c'

o.clipboard = 'unnamedplus'
o.hidden = true
o.mmp = 5000
o.termguicolors = true
o.showmode = false
o.incsearch = true
o.grepprg = 'rg --vimgrep --smart-case --follow'
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.spelllang = 'en_gb'
o.completeopt = 'menu,menuone,noselect'
o.foldlevelstart = 99
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
wo.list = true
wo.number = true
wo.relativenumber = true
wo.spell = true
wo.signcolumn = 'yes'
wo.foldmethod = 'expr'
wo.foldexpr = 'nvim_treesitter#foldexpr()'
g.syntax_on = true
g.do_filetype_lua = 1
g.did_load_filetypes = 0

