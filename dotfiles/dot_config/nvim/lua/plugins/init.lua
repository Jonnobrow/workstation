return require('packer').startup {
  function()
    -- Package Manager
    use 'wbthomason/packer.nvim'

    -- Improve Startup Times
    use {
      'lewis6991/impatient.nvim',
      config = function()
        require 'impatient'
      end,
    }

    -- Colorscheme
    use {
      'folke/tokyonight.nvim',
      config = function()
        require 'plugins.tokyonight'
      end,
    }

    -- Useful Functions
    use 'nvim-lua/plenary.nvim'

    -- Line
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        {
          'SmiteshP/nvim-gps',
          config = function()
            require('nvim-gps').setup()
          end,
        },
        { 'kyazdani42/nvim-web-devicons' },
      },
      config = function()
        require('plugins.lualine')
      end,
      after = 'tokyonight.nvim',
    }

    -- Git stuff
    use {
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('gitsigns').setup()
      end,
      opt = true,
      event = 'BufRead',
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'windwp/nvim-ts-autotag',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-refactor',
      },
      run = ':TSUpdate',
      --config = function()
      --  require 'plugins.treesitter'
      --end,
    }

    -- Better comments
    use {
      'numtostr/comment.nvim',
      config = function()
        require('Comment').setup()
      end,
      event = 'BufWinEnter',
    }

    -- Fuzzy Finder
    use {
      'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- Sessions
    use {
      'rmagatti/auto-session',
      --config = function()
      --  require('plugins.auto-session')
      --end,
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require 'lsp'
      end,
      requires = {
        { 'williamboman/nvim-lsp-installer' },
        {
          'j-hui/fidget.nvim',
          config = function()
            require('fidget').setup {}
          end,
        },
        { 'b0o/SchemaStore.nvim' },
        {
          'jose-elias-alvarez/null-ls.nvim',
          --config = function()
          --  require('lsp.providers.null_ls')
          --end,
          after = 'nvim-lspconfig',
        },
        {
          'ray-x/lsp_signature.nvim',
          --config = function()
          --  require('plugins.lsp-signature')
          --end,
          after = 'nvim-lspconfig',
        },
      },
    }
    use {
      'onsails/lspkind-nvim',
      event = 'InsertEnter',
    }
    use {
      'hrsh7th/nvim-cmp',
      --config = function()
      --  require('plugins.nvim-cmp')
      --end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          --config = function()
          --  require('plugins.luasnip')
          --end,
          requires = {
            'rafamadriz/friendly-snippets',
          },
        },
        { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'cmp-nvim-lsp' },
        { 'saadparwaiz1/cmp_luasnip', after = 'cmp-nvim-lsp-signature-help' },
        { 'hrsh7th/cmp-buffer', after = 'cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua', after = 'cmp-buffer' },
        { 'hrsh7th/cmp-path', after = 'cmp-nvim-lua' },
        { 'hrsh7th/cmp-emoji', after = 'cmp-path' },
        {
          'windwp/nvim-autopairs',
          --config = function()
          --  require('plugins.autopairs')
          --end,
          after = 'nvim-cmp',
        },
      },
      event = 'InsertEnter',
    }

    -- Better keybindings
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup {}
      end,
    }

    -- Markdown Previews
    use 'ellisonleao/glow.nvim'

    -- Git
    use {
      'tpope/vim-fugitive',
      opt = true,
      cmd = 'G',
    }

    -- Make it fancy
    use {
      'folke/zen-mode.nvim',
      config = function()
        require('plugins.zen-mode')
      end,
      requires = {
        {
          'folke/twilight.nvim',
          config = function()
            require('plugins.twilight')
          end,
        },
      },
    }
  end,
  config = {
    compile_path = vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua',
  },
}
