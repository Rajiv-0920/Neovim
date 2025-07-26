-- lua/plugins/lualine.lua
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto', -- Automatically adapts to 'moonlight'
        icons_enabled = true,
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha', 'dashboard', 'NvimTree' },
        },
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = {
          { 'branch', icon = '' },
          'diff',
          { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_c = {
          { 'filename', path = 1, symbols = { modified = '●', readonly = '󰌾', unnamed = '[No Name]' } },
        },
        lualine_x = {
          { 'filetype', icon_only = true },
          'encoding',
          'fileformat',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'nvim-tree', 'quickfix', 'toggleterm' },
    }
  end,
}
