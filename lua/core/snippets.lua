-- ─── Diagnostic Sign Icons ─────────────────────────────────────────────
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = '󰌵 ',
  Info = ' ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ─── Diagnostic Display Settings ───────────────────────────────────────
vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    spacing = 2,
    severity = nil, -- show all severities
    source = 'if_many', -- only show source if multiple
    format = function(d)
      local code = d.code and string.format(' [%s]', d.code) or ''
      return string.format('%s%s', d.message, code)
    end,
  },
  signs = true,
  underline = {
    severity = vim.diagnostic.severity.ERROR,
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    focusable = true,
    header = '',
    prefix = '',
  },
}

-- ─── Transparent Background for Virtual Text ───────────────────────────
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = 'NONE' })

-- ─── Yank Highlight ────────────────────────────────────────────────────
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- ─── Kitty Terminal Padding Tweak ──────────────────────────────────────
vim.cmd [[
  augroup KittyPadding
    autocmd!
    autocmd VimEnter * silent! !kitty @ set-spacing padding=0 margin=0 3 0 3
    autocmd VimLeave * silent! !kitty @ set-spacing padding=default margin=default
  augroup END
]]

-- ─── Prevent LSP from Overriding Tree-sitter Highlights ────────────────
vim.hl.priorities.semantic_tokens = 95
