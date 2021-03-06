vim.cmd [[syntax on]]
vim.o.clipboard = 'unnamedplus'
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.updatetime = 125
vim.o.scrolloff = 5
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.inccommand = 'split'
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.wo.signcolumn = 'yes'
vim.wo.number = true
vim.wo.wrap = true
vim.wo.cursorline = true
vim.wo.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.mouse = 'a'
vim.o.errorbells = false
vim.o.title = true
vim.o.ruler = true
vim.o.showcmd = true
vim.o.startofline = false
vim.o.backspace = 'indent,eol,start'
vim.o.wildmenu = true
vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.opt.formatoptions:remove 't'
vim.opt.formatoptions:remove 'o'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.opt.laststatus = 3
vim.o.completeopt = 'menu,menuone,noselect'

vim.diagnostic.config {
  signs = false, -- rely on highlight styles instead, don't want to clobber signcolumn
  float = {
    header = false,
    source = 'always',
  },
}
