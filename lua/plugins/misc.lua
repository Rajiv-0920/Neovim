-- Standalone plugins with less than 10 lines of config go here
return {
  {
    -- autoclose tags
    'windwp/nvim-ts-autotag',
  },
  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    opts = {
      -- win = {
      --   border = {
      --     { '┌', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '┐', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --     { '┘', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '└', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --   },
      -- },
    },
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()

      local api = require 'Comment.api'
      local opts = { noremap = true, silent = true }

      -- Normal mode: toggle line comment
      vim.keymap.set('n', '<leader>c', api.toggle.linewise.current, opts)

      -- Visual mode: toggle comment on selected lines
      vim.keymap.set('x', '<leader>c', function()
        api.toggle.linewise(vim.fn.visualmode())
      end, opts)
    end,
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mini.surround').setup {
        mappings = {
          add = 'ys', -- ysurround
          delete = 'ds', -- delete surround
          replace = 'cs', -- change surround
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = 'TroubleToggle',
    opts = {}, -- or custom config
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}
