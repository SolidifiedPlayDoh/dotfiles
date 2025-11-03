# Ghostty Configuration

This dotfiles repository includes a custom Ghostty configuration with tmux-inspired, vim-oriented keybindings for terminal multiplexing without the rendering overhead of tmux.

## Overview

- **Native Rendering**: Direct GPU-accelerated rendering (faster than tmux)
- **Tmux-inspired Workflow**: Familiar split and tab management
- **Vim-oriented Navigation**: Modal-style prefix key with vim movement keys
- **Conflict Avoidance**: `ctrl+s` prefix chosen to coexist with tmux when needed

## Architecture

### Configuration Files

```
~/.config/ghostty/config              -> Main configuration
~/.config/ghostty/config-keybind      -> Separate keybinding file
```

The main config includes the keybind file via `config-file = config-keybind`, keeping navigation bindings separate and maintainable.

## Design Philosophy

### Why Ghostty Over Tmux?

**Performance**: Ghostty renders directly to the GPU without an intermediary layer, providing faster rendering and lower latency than terminal + tmux.

**Use Cases**:

- Local development with split panes
- Fast terminal UI applications
- Single-machine workflows

**When to Still Use Tmux**:

- Remote session persistence
- Session sharing
- Complex scripted layouts
- Working across SSH connections

### Keybinding Strategy

**Prefix Key: `ctrl+s`**

Chosen to avoid conflicts with:

- Tmux default prefix (`ctrl+b`)
- Common tmux alternative prefix (`ctrl+a`)
- Standard terminal shortcuts

This allows Ghostty and tmux to coexist when needed (e.g., using Ghostty locally with tmux over SSH).

**Design Influences**:

1. **[gpakosz/.tmux](https://github.com/gpakosz/.tmux)** - Modern tmux configuration
   - Prefix-based command structure
   - Vim-style pane navigation
   - Tab/window management patterns

2. **Vim Navigation** - Classic vim movement paradigm
   - `h/j/k/l` directional movement
   - `gg` / `G` for top/bottom
   - `u` / `d` for page up/down
   - `[` / `]` for jumping between items

## Keybinding Reference

### Split Management

**Navigation**:

- `ctrl+s h` - Move to left split
- `ctrl+s j` - Move to split below
- `ctrl+s k` - Move to split above
- `ctrl+s l` - Move to right split

**Creation**:

- `ctrl+s shift+\` - New split on left
- `ctrl+s shift+-` - New split on right
- `ctrl+s -` - New split below

**Resizing**:

- `ctrl+s shift+H/J/K/L` - Resize split (200/167 pixels)
- `ctrl+s x shift+H/J/K/L` - Extra resize split (400/333 pixels)

**Management**:

- `ctrl+s z` - Toggle split zoom (maximize/restore)
- `ctrl+s =` - Equalize all splits
- `ctrl+s q` - Close current split

### Tab Management

**Navigation**:

- `ctrl+s n` - Next tab
- `ctrl+s p` - Previous tab
- `ctrl+s tab` - Last active tab
- `ctrl+s 0-9` - Jump to tab by number

**Management**:

- `ctrl+s c` - Create new tab
- `ctrl+s w` - Toggle tab overview
- `ctrl+s shift+<` - Move tab left
- `ctrl+s shift+>` - Move tab right

### Vim-oriented Scrolling

**Buffer Navigation**:

- `ctrl+s g g` - Scroll to top (vim `gg`)
- `ctrl+s shift+g` - Scroll to bottom (vim `G`)
- `ctrl+s u` - Scroll page up (vim `ctrl+u`)
- `ctrl+s d` - Scroll page down (vim `ctrl+d`)

**Prompt Jumping**:

- `ctrl+s [` - Jump to previous prompt
- `ctrl+s ]` - Jump to next prompt

### Screen Management

- `ctrl+s ctrl+l` - Clear screen (like tmux `ctrl+l`)
- `ctrl+s ctrl+,` - Reload config
- `ctrl+s ?` - Toggle command palette

### Standard Ghostty Shortcuts

These work without the prefix:

- `cmd+d` - New split right
- `cmd+shift+d` - New split down
- `cmd+t` - New tab
- `cmd+w` - Close tab
- `option+grave` - Toggle quick terminal (global)

## Key Design Decisions

### Prefix vs Direct Bindings

**Prefix-based (`ctrl+s`)**:

- Tmux-like workflow familiarity
- Avoids conflicts with other tools
- Allows for modal, discoverable keybindings
- Supports complex key sequences (e.g., `ctrl+s g g`)

**Direct bindings (`cmd+key`)**:

- Reserved for most common operations
- macOS-native feel
- Faster single-key access

### Copy Mode Omission

**Decision**: Not implementing tmux-style copy mode in Ghostty.

**Rationale**:

- Ghostty has native macOS text selection
- System clipboard integration works natively
- tmux copy mode is complex and terminal-specific
- Native selection is faster and more intuitive on desktop

### Reload Configuration

**Decision**: `ctrl+s ctrl+,` instead of opening config editor.

**Rationale**:

- Dotfiles are managed by Chezmoi
- Editing installed config doesn't persist
- Must edit source files in dotfiles repo
- Quick reload is more useful than editor launch

## Integration with Development Workflow

### Shell Integration

Ghostty includes built-in shell integration features:

```toml
shell-integration = zsh
shell-integration-features = cursor,sudo,title
```

This enables:

- Smart cursor positioning
- Sudo password prompts
- Dynamic terminal titles
- Prompt jumping with `ctrl+s [` and `ctrl+s ]`

### Font Configuration

Optimized for programming with ligatures:

```toml
font-family = MonoLisa Nerd Font, MonoLisa
font-feature = +calt,+liga,+dlig,+zero,+ss02,+ss10,+ss11,+ss12,+ss13,+ss14,+ss15,+ss16font-size = 10
```

### Theme

Consistent dark theme to avoid flashing:

```toml
theme = Catppuccin Mocha
unfocused-split-opacity = 0.80
unfocused-split-fill = 121218
```

### Claude Code Integration

Special keybinding for Claude Code's shift+enter:

```toml
keybind = shift+enter=text:\x1b\r
```

Sends escape + return for multi-line input in Claude Code.

## Customization

### Adding Keybindings

Edit `home/dot_config/ghostty/config-keybind` in your dotfiles:

```toml
keybind = ctrl+s>custom_key=action_name# Add custom keybinding
```

### Available Actions

View all available Ghostty actions:

```bash
ghostty +list-actions
```

### Key Sequence Syntax

Ghostty supports key chaining with `>`:

```toml
keybind = ctrl+s>n=next_tab

keybind = ctrl+s>g>g=scroll_to_top

keybind = ctrl+s>shift+h=resize_split:left,200# Single key after prefix
# Multi-key sequence
# With modifiers
```

### Finding Keybindings

**View Config**:

```bash
ghostty +show-config
```

**View Defaults**:

```bash
ghostty +show-config --default --docs
```

## Chezmoi Integration

### Source Files

```
dotfiles/home/dot_config/ghostty/config          -> ~/.config/ghostty/config
dotfiles/home/dot_config/ghostty/config-keybind  -> ~/.config/ghostty/config-keybind
```

### Applying Changes

```bash
# Preview changes
chezmoi diff

# Apply changes
chezmoi apply

# Reload Ghostty config
ctrl+s ctrl+,
```

## Performance Comparison

| Feature             | Ghostty    | Tmux                  |
| ------------------- | ---------- | --------------------- |
| Rendering           | Direct GPU | Terminal → Tmux → GPU |
| Latency             | ~5-10ms    | ~15-30ms              |
| Session Persistence | No         | Yes                   |
| Remote Sessions     | No         | Yes                   |
| Local Performance   | Excellent  | Good                  |
| Memory Usage        | Lower      | Higher                |

## Troubleshooting

### Keybinding Not Working

1. Check syntax: `ghostty +show-config`
2. Reload config: `ctrl+s ctrl+,`
3. Verify action exists: `ghostty +list-actions`
4. Check for conflicts with macOS or other apps

### Split Navigation Issues

- Ensure you're using `ctrl+s` prefix before `h/j/k/l`
- Try `cmd+option+arrow` as alternative
- Check split actually exists in that direction

### Config Changes Not Applying

- Remember to use Chezmoi: `chezmoi apply`
- Don't edit `~/.config/ghostty/` directly (changes won't persist)
- Edit source files in `dotfiles/home/dot_config/ghostty/`

### Performance Issues

- Check GPU acceleration is enabled
- Disable shell integration temporarily to test
- Reduce split count (each split is a separate process)

## References

- [Ghostty Documentation](https://ghostty.org/docs) - Official documentation
- [Ghostty Config Reference](https://ghostty.org/docs/config) - All configuration options
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) - Tmux keybinding inspiration
- [Chezmoi Documentation](https://www.chezmoi.io/) - Dotfiles management
