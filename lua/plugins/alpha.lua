return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Custom ASCII art header (moonlight-inspired)
    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }

    -- Menu buttons
    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
      dashboard.button('g', '  Live Grep', ':Telescope live_grep<CR>'),
      dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
      dashboard.button('n', '  New File', ':ene <BAR> startinsert <CR>'),
      dashboard.button('s', '  Find Word', ':Telescope grep_string<CR>'),
      dashboard.button('c', '  Config', ':e $MYVIMRC<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    -- Custom footer
    local function footer()
      local total_plugins = #vim.tbl_keys(require('lazy').plugins())
      local datetime = os.date('%A %d %B %Y %H:%M:%S')
      local version = vim.version()
      return string.format(
        '⚡ %d plugins |  %s | 󱓟 nvim v%d.%d.%d',
        total_plugins,
        datetime,
        version.major,
        version.minor,
        version.patch
      )
    end

    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = 'Comment'
    dashboard.section.header.opts.hl = 'Type'
    dashboard.section.buttons.opts.hl = 'Keyword'

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    -- Optional: update footer after lazy startup
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(alpha.setup, dashboard.opts)
      end,
    })
  end,
}
