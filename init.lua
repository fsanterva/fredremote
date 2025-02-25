local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- File explorer and plugin manager
  use 'preservim/nerdtree'
  use 'wbthomason/packer.nvim'

  -- LSP and autocompletion
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- Treesitter for better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- == Themes and UI enhancements ==
  
  -- use 'sainnhe/everforest'
  use 'shaunsingh/nord.nvim'

  use 'ap/vim-css-color'
  use 'Yggdroot/indentLine'
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'alvan/vim-closetag'
  use 'nvim-lualine/lualine.nvim'
  use 'numToStr/Comment.nvim'

  -- Telescope for fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable('make') == 1,
  }

  -- Git-related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- Load custom plugins from external file
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  -- Bootstrap packer if needed
  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

require("fredjil")



-- Set 'jjj' to enter terminal mode
-- See `:help vim.keymap.set()`

-- vim.cmd("augroup ProjectDrawer")
-- vim.cmd("autocmd VimEnter * :cd /mnt/c/wamp64/www/devs/wp/")
-- vim.cmd("autocmd VimEnter * :Vexplore")
-- vim.cmd("autocmd VimEnter * :Lex")
-- vim.cmd("augroup END")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
