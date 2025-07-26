return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'lukas-reineke/cmp-under-comparator',
    -- Optional: Copilot
    -- 'zbirenbaum/copilot-cmp',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()

    local kind_icons = {
      Text = '󰉿',
      Method = 'm',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '󰆧',
      Class = '󰌗',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰇽',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰊄',
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
        -- { name = 'copilot' }, -- optional
      }),
      sorting = {
        priority_weight = 2,
        comparators = {
          require('cmp-under-comparator').under,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          vim_item.kind = kind_icons[vim_item.kind] or ''
          vim_item.menu = ({
            buffer = '[Buf]',
            nvim_lsp = '[LSP]',
            luasnip = '[Snip]',
            path = '[Path]',
            -- copilot = '[]',
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- Cmdline completions (optional)
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'path' },
        { name = 'cmdline' },
      },
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })
  end,
}
