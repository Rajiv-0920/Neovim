return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    -- Setup nvim-notify with fade and minimal style
    require('notify').setup {
      stages = 'fade', -- "fade", "slide", "fade_in_slide_out", or "static"
      timeout = 2000,
      render = 'minimal', -- minimal rendering
      background_colour = '#000000', -- black transparent background
      fps = 60,
    }

    vim.notify = require 'notify' -- global notify

    require('noice').setup {
      cmdline = {
        view = 'cmdline_popup',
        format = {
          cmdline = { icon = '', title = '' },
          search_down = { icon = '', title = '' },
          search_up = { icon = '', title = '' },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 10,
            col = '50%',
          },
          size = {
            width = 40,
            height = 'auto',
          },
          border = {
            style = 'single',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
      },
      lsp = {
        progress = { enabled = false },
        signature = { enabled = true, auto_open = { enabled = true } },
        hover = { enabled = true, view = 'mini' },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    }

    -- Fade-style minimal highlights
    vim.cmd [[
      hi! link NormalFloat Normal
      hi! FloatBorder guifg=#6c7086 guibg=NONE
      hi! NotifyBackground guibg=NONE
      hi! NotifyERRORBorder guifg=#f38ba8 guibg=NONE
      hi! NotifyWARNBorder guifg=#f9e2af guibg=NONE
      hi! NotifyINFOBorder guifg=#89dceb guibg=NONE
      hi! NotifyDEBUGBorder guifg=#cdd6f4 guibg=NONE
      hi! NotifyTRACEBorder guifg=#b4befe guibg=NONE
    ]]
  end,
}
