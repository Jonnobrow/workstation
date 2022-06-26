--
-- Bootstraps and configures packer and sets up plugins.
--
-- inspiration: https://github.com/williamboman/nvim-config/blob/main/lua/wb/plugins.lua

-- Define the path packer should be installed at
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- Wrap bootstrap in a function so that it can be used in multiple places
local function install_packer()
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

-- If packer is not setup, install it
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  install_packer()
end

-- Load packer
vim.cmd [[packadd packer.nvim]]

-- Create a global function to nuke packer and re-install
function _G.packer_upgrade()
  vim.fn.delete(install_path, 'rf')
  install_packer()
end

-- Map PackerUpgrade to the previous lua function
vim.cmd [[command! PackerUpgrade :call v:lua.packer_upgrade()]]

-- Define the packer spec
local function spec(use)
  -- Make vim quick to start
  use { 'lewis6991/impatient.nvim' }

  -- UI and Syntax
  use {
    {
      'glepnir/zephyr-nvim',
      requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
      config = function()
        require 'zephyr'
      end,
    },
    {
      'editorconfig/editorconfig-vim',
      setup = function()
        vim.g.EditorConfig_max_line_indicator = ''
        vim.g.EditorConfig_preserve_formatoptions = 1
      end,
    },
    {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup {
          input = {
            winblend = 10,
            winhighlight = 'Normal:DressingInputNormalFloat,NormalFloat:DressingInputNormalFloat,FloatBorder:DressingInputFloatBorder',
            border = 'single',
          },
        }
      end,
    },
    { 'kyazdani42/nvim-web-devicons' },
    {
      'lukas-reineke/indent-blankline.nvim',
      setup = function()
        vim.g.indent_blankline_use_treesitter = true
        vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
        vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
        vim.g.indent_blankline_char = '▏'
        vim.cmd [[set colorcolumn=99999]]
      end,
      config = function()
        require('indent_blankline').setup {
          show_current_context = true,
          show_current_context_start = true,
        }
      end,
    },
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        -- TODO: Configure colorizer
        -- require("jonnobrow.nvim-colorizer").setup()
      end,
    },
  }

  -- Neovim extensions and decoration
  use {
    {
      'jghauser/mkdir.nvim',
    },
    {
      'Pocco81/AbbrevMan.nvim',
    },
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    },
    {
      'windwp/nvim-autopairs',
      config = function()
        require('jonnobrow.nvim-autopairs').setup()
      end,
    },
    {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'petertriho/cmp-git',
        {
          'L3MON4D3/LuaSnip',
          requires = { 'rafamadriz/friendly-snippets' },
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
        {
          'onsails/lspkind-nvim',
          config = function()
            require('lspkind').init()
          end,
        },
      },
      config = function()
        require('jonnobrow.cmp').setup()
      end,
    },
    {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup()
      end,
    },
    {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('todo-comments').setup()
      end,
    },
    {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end,
    },
    { 'sindrets/winshift.nvim' },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      },
      config = function()
        require('jonnobrow.neo-tree').setup()
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      requires = {
        'arkav/lualine-lsp-progress',
        {
          'SmiteshP/nvim-gps',
          config = function()
            require('nvim-gps').setup()
          end,
        },
      },
      config = function()
        require('jonnobrow.lualine').setup()
      end,
    },
    {
      'akinsho/toggleterm.nvim',
      config = function()
        require('toggleterm').setup {
          direction = "float",
          insert_mappings = false,
          env = {
            MANPAGER = 'less -X',
          },
          terminal_mappings = false,
          start_in_insert = false,
          open_mapping = [[<leader>t]],
          highlights = {
            CursorLineSign = { link = 'DarkenedPanel' },
            Normal = { guibg = '#14141A' },
          },
        }
        -- Remove WinEnter to allow moving a toggleterm to new tab
        vim.cmd [[autocmd! ToggleTermCommands WinEnter]]
        vim.cmd [[autocmd TermEnter term://*toggleterm#* tnoremap <buffer> <C-t> <Esc><Cmd>ToggleTerm<CR>]]
        vim.cmd [[autocmd TermEnter term://*toggleterm#* nnoremap <buffer> <C-t> <Esc><Cmd>ToggleTerm<CR>]]
      end,
    },
  }

  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    'folke/lua-dev.nvim',
    'b0o/SchemaStore.nvim',
    'ray-x/lsp_signature.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'j-hui/fidget.nvim',
    {
      'zbirenbaum/neodim',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('neodim').setup()
      end,
    },
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require('jonnobrow.telescope').setup()
    end,
  }

  -- Git
  use {
    { 'rhysd/git-messenger.vim' },
    { 'rhysd/committia.vim' },
    {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('jonnobrow.gitsigns').setup()
      end,
    },
  }
end

-- Call Packer Startup
require('packer').startup {
  spec,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    max_jobs = vim.fn.has 'win32' == 1 and 5 or nil,
  },
}
