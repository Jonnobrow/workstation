local actions = require 'telescope.actions'
local layout_actions = require 'telescope.actions.layout'

local M = {}

M.setup = function()
  require('telescope').load_extension 'fzf'

  require('telescope').setup {
    defaults = {
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      prompt_prefix = '  ',
      selection_caret = '  ',
      selection_strategy = 'reset',
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--glob=!.git/',
      },
      sorting_strategy = 'descending',
      layout_strategy = 'flex',
      layout_config = {
        horizontal = {
          preview_cutoff = 0,
          preview_width = 0.6,
        },
        vertical = {
          preview_cutoff = 0,
          preview_height = 0.65,
        },
      },
      path_display = { truncate = 3 },
      color_devicons = true,
      winblend = 5,
      set_env = { ['COLORTERM'] = 'truecolor' },
      -- TODO: Make it prettier
      border = {},
      borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      mappings = {
        i = {
          ['<C-w>'] = function()
            vim.api.nvim_input '<c-s-w>'
          end,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-p>'] = actions.cycle_history_prev,
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-l>'] = layout_actions.toggle_preview,
          ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          ['<Esc>'] = actions.close,
          ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_previous,
        },
      },
    },
    extensions = {
      project = {
        hidden_files = false,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  }

  local wk = require 'which-key'
  wk.register {
    ['<leader>f'] = {
      name = '+find',
      f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", 'Files' },
      g = { "<cmd>lua require('telescope.builtin').git_files()<cr>", 'Git Files' },
      l = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", 'Current Buffer Fuzzy' },
      p = { "<cmd>lua require('telescope').extensions.project.project()<cr>", 'Project' },
      q = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", 'Live Grep' },
      h = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", 'Old Files' },
      s = { "<cmd>lua require('telescope.builtin').git_status()<cr>", 'Git Status' },
      S = { "<cmd>lua require('telescope.builtin').git_stash()<cr>", 'Git Stash' },
      b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", 'Buffers' },
    },
  }
end

return M
