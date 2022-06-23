local M = {}

M.setup = function()
  require('gitsigns').setup {
    keymaps = {},
    current_line_blame = true,
    current_line_blame_opts = {
      delay = vim.o.updatetime,
    },
  }

  local wk = require 'which-key'
  wk.register {
    [']c'] = { '<cmd>lua require"gitsigns".next_hunk()<CR>', 'Next Hunk', noremap=true },
    ['[c'] = { '<cmd>lua require"gitsigns".prev_hunk()<CR>', 'Previous Hunk', noremap=true },
    ['<leader>g'] = {
      name = '+git',
      a = { '<cmd>lua require"gitsigns".stage_hunk()<CR>', 'Stage Hunk', noremap=true },
      r = { '<cmd>lua require"gitsigns".reset_hunk()<CR>', 'Reset Hunk', noremap=true },
      p = { '<cmd>lua require"gitsigns".preview_hunk()<CR>', 'Preview Hunk', noremap=true },
      u = { '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'Undo Stage Hunk', noremap=true },
    },
  }
end

return M
