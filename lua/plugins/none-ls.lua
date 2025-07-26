return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  event = 'VeryLazy',
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Setup mason-null-ls
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'eslint_d',
        'stylua',
        'shfmt',
        'ruff',
        'terraform_fmt',
        'checkmake',
        'clang_format',
        'cppcheck',
      },
      automatic_installation = true,
    }

    -- Define sources
    local sources = {
      -- Diagnostics
      require 'none-ls.diagnostics.eslint_d',
      require 'none-ls.diagnostics.ruff',
      diagnostics.checkmake,
      diagnostics.cppcheck,

      -- Formatters
      formatting.prettier.with {
        filetypes = {
          'javascript',
          'typescript',
          'vue',
          'css',
          'scss',
          'html',
          'json',
          'yaml',
          'markdown',
        },
      },
      formatting.stylua,
      formatting.shfmt.with { extra_args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with {
        extra_args = { '--extend-select', 'I' },
      },
      require 'none-ls.formatting.ruff_format',
      formatting.clang_format,
    }

    -- Autoformatting group
    local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })

    -- Setup none-ls with conditional autoformatting
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
          local filename = vim.api.nvim_buf_get_name(bufnr)

          -- Disable autoformat for .env files
          if filename:match '%.env' then
            return
          end

          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
}
