local M = {}

M.setup = function()
  require('gitsigns').setup {
    keymaps = {},
    current_line_blame = true,
    current_line_blame_opts = {
      delay = vim.o.updatetime,
    },
    signs = {
      add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
  }

  local wk = require 'which-key'
  wk.register {
    [']c'] = { '<cmd>lua require"gitsigns".next_hunk()<CR>', 'Next Hunk', noremap = true },
    ['[c'] = { '<cmd>lua require"gitsigns".prev_hunk()<CR>', 'Previous Hunk', noremap = true },
    ['<leader>g'] = {
      name = '+git',
      a = { '<cmd>lua require"gitsigns".stage_hunk()<CR>', 'Stage Hunk', noremap = true },
      A = { '<cmd>lua require"gitsigns".stage_buffer()<CR>', 'Stage Buffer', noremap = true },
      r = { '<cmd>lua require"gitsigns".reset_hunk()<CR>', 'Reset Hunk', noremap = true },
      p = { '<cmd>lua require"gitsigns".preview_hunk()<CR>', 'Preview Hunk', noremap = true },
      u = { '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', 'Undo Stage Hunk', noremap = true },
      t = {
        name = '+toggles',
        d = { '<cmd>lua require"gitsigns".toggle_deleted()<CR>', 'Toggle Deleted', noremap = true },
        s = { '<cmd>lua require"gitsigns".toggle_signs()<CR>', 'Toggle Signs', noremap = true },
        n = { '<cmd>lua require"gitsigns".toggle_numhl()<CR>', 'Toggle Num Highlight', noremap = true },
        l = { '<cmd>lua require"gitsigns".toggle_linehl()<CR>', 'Toggle Line Highlight', noremap = true },
        w = { '<cmd>lua require"gitsigns".toggle_word_diff()<CR>', 'Toggle Word Diff', noremap = true },
      },
      D = { '<cmd>lua require"gitsigns".diffthis()<CR>', 'Diff This', noremap = true },
    },
  }
end

return M
