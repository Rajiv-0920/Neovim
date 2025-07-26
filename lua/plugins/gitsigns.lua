-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      signs                        = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '󰍴' },
        topdelete    = { text = '󰍴' },
        changedelete = { text = '▎' },
        untracked    = { text = '┆' },
      },
      signcolumn                   = true,
      numhl                        = false,
      linehl                       = false,
      word_diff                    = false,
      watch_gitdir                 = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked          = true,
      current_line_blame           = true,
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 200,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil,
      max_file_length              = 40000,
      preview_config               = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, opts)
          opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
        map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
        map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
        map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
        map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
        map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
        map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
        map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
        map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
        map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
      end
    }
  end
}
