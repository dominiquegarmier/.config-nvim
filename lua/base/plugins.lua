-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',

  -- which key
  { 'folke/which-key.nvim',             opts = {} },

  -- treesitter
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- mason
  { 'williamboman/mason.nvim' },

  -- lsp stuff
  { 'williamboman/mason-lspconfig.nvim' },
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },

  -- none / null ls
  { "jay-babu/mason-null-ls.nvim" },
  { "nvimtools/none-ls.nvim" },
  { 'williamboman/mason.nvim' },

  -- copilot
  { "zbirenbaum/copilot.lua" },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- telescope file tree
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  -- harpoon
  { 'theprimeagen/harpoon' },

  -- undo tree
  { 'mbbill/undotree' },

  -- git worktree
  {'ThePrimeagen/git-worktree.nvim'},

  -- tmux
  { 'christoomey/vim-tmux-navigator' },

  -- Theme
  { 'xiyaowong/transparent.nvim' },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup()

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end,
  },
})
