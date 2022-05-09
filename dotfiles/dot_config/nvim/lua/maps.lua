local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','


local wk = require "which-key"

wk.register {
  ["<leader>"] = {
    c = {
      name = "+Quickfix",
      k    = {"<cmd>cexpr []<cr>", "Clear"},
      c    = {"<cmd>cclose <cr>", "Close"},
      o    = {"<cmd>copen <cr>", "Open"},
      f    = {"<cmd>cfdo %s/", "Replace in all files"},
      p    = {"<cmd>cprev<cr>zz", "Previous"},
      n    = {"<cmd>cnext<cr>zz", "Next"}
    },
    b = {
      name = "+Buffers",
      p    = {"<cmd>bprev<cr>", "Previous"},
      n    = {"<cmd>bnext<cr>", "Next"},
      d    = {"<cmd>bdelete<cr>", "Delete"},
      N    = {"<cmd>enew<cr>", "New"},
      b    = {"<cmd>e #<cr>", "Swap"}
    },
    z = {"<cmd>lua require('zen-mode').toggle()<cr>", "Zen Mode"},
    f = {
      name = "+Find",
      f    = {"<cmd>lua require('fzf-lua').files()<cr>", "Files"},
      g    = {"<cmd>lua require('fzf-lua').git_files()<cr>", "Git Files"},
      s    = {"<cmd>lua require('fzf-lua').live_grep_native()<cr>", "Live Grep"},
      b    = {"<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers"},
      c    = {"<cmd>lua require('fzf-lua').git_commits()<cr>", "Git Commits"}
    },
    ["/"] = {"<cmd>lua require('fzf-lua').live_grep_native()<cr>", "Live Grep"},
  }  
}
