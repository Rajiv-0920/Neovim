require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymap
require 'core.snippets' -- Custom code snippets

-- Spell Check
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'en_gb' }

-- Install package manager
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

-- Import color theme based on environment variable NVIM_THEME
local default_color_scheme = 'moonlight'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  nord = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
  moonlight = 'plugins.themes.moonlight',
}

-- Setup plugins
require('lazy').setup({
  require(themes[env_var_nvim_theme]),
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.lualine',
  require 'plugins.bufferline',
  require 'plugins.neo-tree',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.lazygit',
  require 'plugins.comment',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.database',
  require 'plugins.misc',
  require 'plugins.harpoon',
  require 'plugins.avante',
  require 'plugins.aerial',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.visual-multi',
  require 'plugins.neoscroll',
  require 'plugins.nvim-notify',
  require 'plugins.noice',
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Function to check if a file exists
local function file_exists(file)
  local f = io.open(file, 'r')
  if f then
    f:close()
    return true
  else
    return false
  end
end

-- Path to the session file
local session_file = '.session.vim'

-- Check if the session file exists in the current directory
if file_exists(session_file) then
  local ok, err = pcall(function()
    vim.cmd('silent! source ' .. session_file)
  end)
  if not ok then
    vim.notify('Failed to load session file: ' .. err, vim.log.levels.ERROR)
  end
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
