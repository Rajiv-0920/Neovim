# Neovim Setup Guide for macOS

This guide helps you set up Neovim on macOS from scratch, including installing plugins, configuring the editor, and enabling LSP support for development.

---

## 1. Prerequisites

### Homebrew Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Essential Tools

```bash
brew install git curl neovim node python3 ripgrep fd luarocks
brew install --cask font-jetbrains-mono
```

---

## 2. Directory Structure

```bash
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/lua/themes
mkdir -p ~/.config/nvim/after/plugin
```

---

## 3. Install Lazy.nvim Plugin Manager

```bash
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim
```

---

## 4. Base Config Files

### `init.lua`

```lua
require("lazy").setup({
  require(themes[env_var_nvim_theme]),
  require("plugins.telescope"),
  require("plugins.treesitter"),
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.none-ls"),
  require("plugins.lualine"),
  require("plugins.bufferline"),
  require("plugins.neo-tree"),
  require("plugins.alpha"),
  require("plugins.indent-blankline"),
  require("plugins.lazygit"),
  require("plugins.comment"),
  require("plugins.debug"),
  require("plugins.gitsigns"),
  require("plugins.database"),
  require("plugins.misc"),
  require("plugins.harpoon"),
  require("plugins.avante"),
  require("plugins.aerial"),
  require("plugins.vim-tmux-navigator"),
  require("plugins.visual-multi"),
  require("plugins.neoscroll"),
  require("plugins.nvim-notify"),
  require("plugins.noice")
})
```

---

## 5. Recommended Plugin Settings

- Treesitter: for syntax highlighting
- Telescope: for fuzzy finding
- LSPConfig: to enable language servers
- mason.nvim: for installing LSPs and tools
- none-ls.nvim: linting/formatting
- cmp.nvim: autocompletion

---

## 6. Language Support

### JavaScript / TypeScript

```bash
npm i -g typescript typescript-language-server eslint_d prettier
```

### Python

```bash
pip install ruff ruff-lsp black isort
```

---

## 7. Fonts

Ensure Nerd Fonts are installed (e.g., JetBrains Mono Nerd Font). Set this in your terminal profile.

---

## 8. Spell Checking

In `init.lua` or `options.lua`:

```lua
vim.opt.spell = true
vim.opt.spelllang = { 'en_gb', 'hi' }
```

---

## 9. Useful Keybindings

- `<leader>ff`: Telescope file finder
- `<leader>gd`: Go to definition
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code action
- `<leader>f`: Format file

---

## 10. Launch Neovim

```bash
nvim
```

You can now start editing and customizing further.

