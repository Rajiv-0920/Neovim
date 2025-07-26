return {
  'shaunsingh/moonlight.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Example config in lua
    vim.g.moonlight_italic_comments = true
    vim.g.moonlight_italic_keywords = true
    vim.g.moonlight_italic_functions = true
    vim.g.moonlight_italic_variables = false
    vim.g.moonlight_contrast = true
    vim.g.moonlight_borders = false
    vim.g.moonlight_disable_background = true

    -- Load the colorscheme
    require('moonlight').set()
    -- Function to set menu borders to transparent
    -- local set_menu_border_transparency = function()
    --   vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', fg = 'NONE' })
    --   vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', fg = 'NONE' })
    -- end

    -- Execute the function once after loading the colorscheme
    -- set_menu_border_transparency()

    local bg_transparent = true

    -- Toggle background transparency
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      vim.g.moonlight_disable_background = bg_transparent
      vim.cmd [[colorscheme moonlight]]
      -- set_menu_border_transparency()
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
