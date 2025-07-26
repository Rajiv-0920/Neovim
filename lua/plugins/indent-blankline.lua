return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl", -- ibl is the new API entry
  opts = {
    indent = {
      char = "▏", -- alternatives: "▏", "┊", "┃", "╎"
      tab_char = "→",
      smart_indent_cap = true,
      priority = 2,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = { "Function", "Label" },
    },
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "dashboard",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "Trouble",
        "neo-tree",
        "alpha",
      },
      buftypes = { "terminal", "nofile", "quickfix" },
    },
  },
  config = function(_, opts)
    -- Enable true color and setup ibl with scope highlight
    vim.opt.termguicolors = true
    require("ibl").setup(opts)

    -- Use Treesitter for context detection if available
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
