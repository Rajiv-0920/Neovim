-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
-- Next buffer with Shift + L
vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)

-- Previous buffer with Shift + H
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>s', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>sx', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(0)
  else
    vim.diagnostic.disable(0)
  end
end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- Run C Program
local function run_code()
  -- Save current file
  vim.cmd 'w'

  -- Get file extension and name without extension
  local ext = vim.fn.expand '%:e'
  local file = vim.fn.expand '%'
  local file_no_ext = vim.fn.expand '%:r'

  local cmd = nil

  if ext == 'c' then
    cmd = string.format('bash -c "gcc %s -o %s && ./%s"', file, file_no_ext, file_no_ext)
  elseif ext == 'cpp' or ext == 'c++' or ext == 'cxx' or ext == 'cc' then
    cmd = string.format('bash -c "g++ %s -o %s && ./%s"', file, file_no_ext, file_no_ext)
  elseif ext == 'java' then
    cmd = string.format('bash -c "javac %s && java %s"', file, file_no_ext)
  elseif ext == 'py' then
    cmd = string.format('python3 %s', file)
  else
    print("Filetype '" .. ext .. "' not supported for auto run")
    return
  end

  -- Open terminal split and run the command
  vim.cmd('belowright split | terminal ' .. cmd)
  -- Optional: focus terminal window (use if needed)
  vim.cmd 'startinsert'
end

-- Map F8 to the above function
vim.keymap.set('n', '<F8>', run_code, { noremap = true, silent = true })

-- Move selected lines down with J
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines up with K
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
