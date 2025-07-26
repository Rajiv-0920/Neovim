return {
  'mg979/vim-visual-multi',
  branch = 'master',
  lazy = false,
  init = function()
    vim.g.VM_default_mappings = 0 -- disable default mappings
    vim.g.VM_maps = {
      ['Find Under'] = '<Leader>m',
      ['Find Subword Under'] = '<Leader>m',
      ['Add Cursor Down'] = '<Leader>j',
      ['Add Cursor Up'] = '<Leader>k',
    }
  end,
}
