# Neovim Configuration

A Lua-based Neovim configuration designed for performance and productivity.

## Structure

```text
lua/
├── config/
│   ├── options.lua    # Basic vim options
│   ├── keymaps.lua    # Global keymaps
│   └── autocmds.lua   # Autocommands
└── plugins/           # Plugin specifications for lazy.nvim
    ├── lsp.lua        # LSP, Mason, and formatting
    ├── completion.lua # CMP and snippets
    ├── ui.lua         # UI elements and colorscheme
    └── treesitter.lua # Syntax highlighting
```

## Plugin Manager

**[lazy.nvim](https://github.com/folke/lazy.nvim)**:
Manages plugin installation and lazy-loading.

## Installation

Symlink the Neovim configuration directory to your `.config`:

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## Note for Windows Machines

When running on Windows, you **must** modify `treesitter.config` to
`treesitter.configs` in the plugin loading section (typically in `plugins.lua`
or wherever Treesitter is initialized) as Windows uses a different
internal name for certain configurations.
