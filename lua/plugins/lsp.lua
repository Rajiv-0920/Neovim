-- insane-lsp.lua
return {
  -- 🧠 LSP + Mason Setup
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'b0o/schemastore.nvim',
      'folke/neodev.nvim',
      'pmizio/typescript-tools.nvim',
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local mason = require 'mason'
      local mason_lsp = require 'mason-lspconfig'
      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 🔧 Setup neodev (for Lua)
      require('neodev').setup()

      -- 🔧 Setup Mason
      mason.setup()

      -- 🔧 Setup Mason LSP installer
      mason_lsp.setup {
        ensure_installed = {
          'lua_ls',
          'pyright',
          'clangd',
          'jsonls',
          'yamlls',
          'html',
          'cssls',
          'bashls',
          'marksman',
          'eslint',
          'dockerls',
          'gopls',
          'rust_analyzer',
          'tailwindcss', -- ✅ Added Tailwind CSS LSP
        },
        automatic_installation = true,
      }

      -- ✅ Setup typescript-tools (replacing tsserver)
      require('typescript-tools').setup {
        capabilities = cmp_capabilities,
      }

      -- ⚙️ LSP Servers config
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
        pyright = {},
        clangd = {},
        html = {},
        cssls = {},
        bashls = {},
        dockerls = {},
        gopls = {},
        rust_analyzer = {},
        eslint = {},
        marksman = {},
        tailwindcss = {}, -- ✅ Tailwind config added here
      }

      -- 🔁 Loop through servers
      for name, config in pairs(servers) do
        config.capabilities = cmp_capabilities
        lspconfig[name].setup(config)
      end
    end,
  },

  -- 🚨 Trouble: Diagnostics UI
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
  },

  -- 🔍 Telescope: fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}
