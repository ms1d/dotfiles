# Zsh Configuration

Modular Zsh configurations tailored for different machines and distributions.

## Requirements

Ensure the following tools and plugins are installed:

- **fzf**: Fuzzy finder
- **zoxide**: Smarter `cd` command
- **eza**: Modern replacement for `ls`
- **zsh-autosuggestions**: Fish-like suggestions
- **zsh-syntax-highlighting**: Syntax highlighting for the shell
- **fzf-tab**: Fzf-based completion

## Configuration Files

- `zshrc_arch`: Main configuration for Arch Linux
- `zshrc_hp_desktop`: Specialized config for HP desktop setup (personal server)
- `zshrc_surface`: Configuration for my Surface Laptop Go 1 (not used often)

## Installation

Choose the configuration file that matches your device and symlink it.

```bash
# Example for Arch Linux
ln -s ~/dotfiles/zsh/zshrc_arch ~/.zshrc
```

## Notes

- Some tools are installed via distro packages, while others are Zsh plugin
- Plugin paths may vary between devices; check and adjust if necessary.
