# Ghostty Configuration

Ghostty config with tmux-inspired, vim-oriented keybindings using `ctrl+s` prefix.

## Files

- `home/dot_config/ghostty/config` - Main configuration
- `home/dot_config/ghostty/config-keybind` - Keybindings (loaded via `config-file`)

## Design Decisions

### Prefix Key: `ctrl+s`

Chosen to avoid conflicts with tmux (`ctrl+b`, `ctrl+a`) and standard terminal shortcuts. Allows Ghostty and tmux to coexist.

### Sources

- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) - Prefix-based commands, vim-style navigation
- Vim movement paradigm - `h/j/k/l`, `gg`/`G`, `u`/`d`, `[`/`]`

### Notable Omissions

**Copy mode**: Not implemented. Native macOS text selection and clipboard integration work better for local terminal usage.

**Config editor binding**: Skipped because dotfiles are managed by Chezmoi - editing installed files doesn't persist.

## Keybindings

All bindings use `ctrl+s` prefix unless noted.

### Splits

- `h/j/k/l` - Navigate left/down/up/right
- `shift+\` - New split left
- `shift+-` - New split right
- `-` - New split down
- `shift+H/J/K/L` - Resize 200/167px
- `x shift+H/J/K/L` - Resize 400/333px (extra)
- `z` - Toggle zoom
- `=` - Equalize splits
- `q` - Close split

### Tabs

- `n/p` - Next/previous tab
- `tab` - Last active tab
- `0-9` - Jump to tab number
- `c` - New tab
- `w` - Tab overview
- `shift+</>` - Move tab left/right

### Scrolling (vim-style)

- `g g` - Top
- `shift+g` - Bottom
- `u/d` - Page up/down
- `[/]` - Previous/next prompt

### Other

- `ctrl+l` - Clear screen
- `ctrl+,` - Reload config
- `?` - Command palette

### Direct (no prefix)

- `cmd+d` / `cmd+shift+d` - New split right/down
- `cmd+t` / `cmd+w` - New/close tab
- `option+grave` - Quick terminal (global)

## Configuration Notes

### Shell Integration

```toml
shell-integration = zsh
shell-integration-features = cursor,sudo,title
```

Enables prompt jumping (`ctrl+s [/]`), sudo prompts, and dynamic titles.

### Claude Code

```toml
keybind = shift+enter=text:\x1b\r
```

Sends escape + return for multi-line input in Claude Code.

### Theme

```toml
theme = Catppuccin Mocha
unfocused-split-opacity = 0.80
unfocused-split-fill = 121218
```

Dark theme only to avoid flashing on new tabs.

## Usage

### Applying Changes

```bash
chezmoi diff          # Preview
chezmoi apply         # Apply
ctrl+s ,         # Reload Ghostty
```

### Useful Commands

```bash
ghostty +list-actions           # List all available actions
ghostty +show-config            # Show current config
ghostty +show-config --default  # Show defaults
```

## References

- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) - Keybinding design source
- [Ghostty Config Reference](https://ghostty.org/docs/config)
