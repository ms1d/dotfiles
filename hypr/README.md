# Hyprland Configuration

Configuration for Hyprland dynamic tiling Wayland compositor and related tools.

## Key Features

- **Blurred Backgrounds**: Works well with the `foot` terminal.
- **Custom Wallpapers**: Manually overwrite wallpapers in `/usr/share/hypr/wall*.png`
- **Integrated Utilities**: `waybar`, `mako`, `fuzzel`, `cliphist`, `playerctl`.

## Dependencies

- **Hyprland**: Tiling compositor
- **Waybar**: Customizable status bar
- **Mako**: Notification daemon
- **Fuzzel**: Application launcher
- **Cliphist**: Clipboard manager
- **Playerctl**: Media player control
- **Foot**: Fast, lightweight terminal emulator

## Installation

Symlink the entire directory to your `.config`:

```bash
ln -s ~/dotfiles/hypr ~/.config/hypr
```

## Monitor & HiDPI

Configuration for HiDPI displays is located in `hidpi.conf`
and sourced in the main `hyprland.conf`. Adjust monitor settings as needed.
