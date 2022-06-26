local wk = require 'which-key'

-- i want to be able to leave terminal yes pls
wk.register({
  ['<Esc>'] = { '<C-\\><C-n>', 'Exit Terminal', noremap = true },
}, { mode = 't' })

-- Window and Buffer Management Keymaps
wk.register {
  ['<leader>w'] = {
    name = '+window',
    h = { '<C-w>h', 'Move Focus Left' },
    j = { '<C-w>j', 'Move Focus Down' },
    k = { '<C-w>k', 'Move Focus Up' },
    l = { '<C-w>l', 'Move Focus Right' },
    H = { '<Cmd>Winshift Left<cr>', 'Move Window Left' },
    J = { '<Cmd>Winshift Down<cr>', 'Move Window Down' },
    K = { '<Cmd>Winshift Up<cr>', 'Move Window Up' },
    L = { '<Cmd>Winshift Right<cr>', 'Move Window Right' },
    q = { '<Cmd>try | close | catch | endtry<CR>', 'Safe Quit' },
    Q = { '<Cmd>q!<CR>', 'Force Quit' },
    v = { '<C-w>v', 'Vertical Split' },
    s = { '<C-w>s', 'Horizontal Split' },
    ['+'] = { '<C-w>+', 'Increase Height' },
    ['-'] = { '<C-w>-', 'Decrease Height' },
    ['>'] = { '2<C-w>>', 'Increase width' },
    ['<'] = { '2<C-w><', 'Decrease width' },
    ['='] = { '<C-w>=', 'Equalize' },
  },
  ['<leader>q'] = { '<Cmd>wq<cr>', "Save and Quit" },
  ['<leader>Q'] = { '<Cmd>q!<cr>', "Force Quit (No Save)"}
}

-- Miscellaneous
wk.register {
  ['<Esc>'] = { '<Cmd>noh<cr>', 'Clear Highlight' },
  ['<Leader>P']= {
    name = '+packer',
    s = { '<Cmd>PackerSync<CR>', 'Sync' },
  },
}
