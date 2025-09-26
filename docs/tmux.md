# Tmux Configuration

This dotfiles repository includes a comprehensive tmux setup based on [gpakosz/.tmux](https://github.com/gpakosz/.tmux) with custom local overrides for enhanced functionality and seamless integration with Neovim and Claude Code.

---

## Overview

- **Base Configuration**: [gpakosz/.tmux](https://github.com/gpakosz/.tmux) – modern, feature-rich tmux setup  
- **External Source**: Managed automatically via Chezmoi externals  
- **Local Overrides**: Custom settings in `home/dot_tmux.conf.local`  
- **Auto-Updates**: External configuration refreshed every 24 hours  
- **Vi Mode**: Enhanced vi-style navigation and copy behavior  

---

## Architecture

### External Configuration

The base tmux configuration is defined as a Chezmoi external in `.chezmoiexternal.toml.tmpl`:

```toml
[".tmux"]
type = "git-repo"
url = "https://github.com/gpakosz/.tmux.git"
refreshPeriod = "24h"
```

This automatically:
- Clones the gpakosz/.tmux repository to `~/.tmux/`
- Keeps it updated daily
- Provides a modern, extensible foundation for local customization

### File Layout

```
~/.tmux.conf       -> Symlink to ~/.tmux/.tmux.conf (managed by Chezmoi)
~/.tmux.conf.local -> Custom local overrides
~/.tmux/           -> External gpakosz/.tmux configuration
```

Local configuration overrides the base settings and persists across updates.

---

## Custom Features

### Vi Mode Navigation

**Location**: `home/dot_tmux.conf.local`

#### Copy Mode
- `setw -g mode-keys vi` – Enables vi-style copy mode  
- `v` – Begin selection  
- `y` – Yank selection and exit copy mode  

#### Pane Navigation
- `prefix + h/j/k/l` – Move between panes  
- `prefix + H/J/K/L` – Resize panes (with repeat)  

---

### Seamless Neovim Integration

**Plugin**: [`christoomey/vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator)

#### Smart Navigation

Vim detection enables unified navigation across tmux and vim splits:

```bash
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
```

#### Keybindings
- `Ctrl+h/j/k/l` – Move between panes or vim splits  
- `Ctrl+\` – Jump to the previous split/pane  

These keys:
- Work inside and outside Neovim  
- Use consistent navigation in copy mode  
- Always fall back to prefix-based movement  

#### Version Compatibility
- **tmux < 3.0** – Single backslash escape  
- **tmux ≥ 3.0** – Double backslash escape  

---

### Custom Keybindings

**Location**: `home/dot_tmux.conf.local`

#### Claude Code Integration
- `prefix + e` – Opens Claude Code in the dotfiles directory  
  - Overrides gpakosz’s default “edit config” binding  
  - Launches a new window named “dotfiles”  
  - Opens the chezmoi working directory  
  - Starts Claude Code for AI-assisted dotfile management  

---

## gpakosz/.tmux Base Features

### Visual Enhancements
- Modern status line with system info, load, and battery indicators  
- Color schemes and window/pane numbering  

### Productivity Tools
- Smart pane splitting and session management  
- Toggleable mouse support  
- Enhanced copy mode  

### Default Keybindings
- `prefix + e` – **Overridden** (now opens Claude Code)  
- `prefix + r` – Reload configuration  
- `prefix + Tab` – Toggle mouse mode  
- Many more available in the upstream documentation  

---

## Installation & Management

### Setup
Install the configuration automatically via Chezmoi:
```bash
chezmoi apply
```

### Updates
```bash
# Refresh external configuration
chezmoi update

# Apply local changes
chezmoi apply
```

### Runtime Commands
```bash
# Open Claude Code (prefix + e)
# Reload config
prefix + r

# View current key bindings
tmux list-keys
```

---

## Customization

### Editing Local Configuration

Edit `home/dot_tmux.conf.local`:

```bash
# Change prefix key
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Example: custom status line
set -g status-right "%H:%M %d-%b-%y"
```

### Plugin Management (TPM)

```bash
# Add to ~/.tmux.conf.local
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Initialize TPM
run '~/.tmux/plugins/tpm/tpm'
```

### Overriding Base Settings

```bash
# Change default window numbering
set -g base-index 0
setw -g pane-base-index 0

# Update split keybindings
bind | split-window -h
bind - split-window -v
```

---

## Integration with Development Workflow

### Neovim
- Unified navigation between splits and panes  
- Consistent vi-style bindings  
- Copy mode behavior aligned with Vim  

### Shell
- Works with zsh, bash, or fish  
- Retains shell history  
- Smart automatic window naming  

### Sessions
```bash
tmux new-session -s dev
tmux attach-session -t dev
tmux list-sessions
```

---

## Troubleshooting

### Navigation
- Ensure `vim-tmux-navigator` is installed  
- Check tmux version for `Ctrl+\` binding  
- Verify `ps` output format for your OS  

### Configuration
- Reload with `prefix + r`  
- Validate syntax: `tmux -f ~/.tmux.conf.local -T`  
- Inspect logs: `tmux show-messages`  

### External Updates
```bash
chezmoi update --force
chezmoi status
```

---

## Performance

Optimized for:
- **Lazy Loading** – Features load on demand  
- **Low Overhead** – Efficient status updates  
- **Smart Detection** – Lightweight vim checks  
- **Caching** – 24-hour external refresh period  

---

## References

- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) – Base configuration  
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) – Navigation plugin  
- [Tmux Manual](http://man.openbsd.org/OpenBSD-current/man1/tmux.1) – Official documentation  