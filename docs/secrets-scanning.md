# Secrets Scanning with TruffleHog

## Problem

Dotfiles repositories risk exposing secrets (API keys, tokens, SSH keys) through:
- Accidental commits of credential files
- Hard-coded secrets in configuration templates
- Leftover credentials in shell history or cache files
- Copy-paste errors when sharing configurations

Without active scanning, these secrets can persist in git history or spread to target systems.

## Design Decisions

### Two-Layer Scanning Approach

**1. Scan on Chezmoi Apply** (`run_after_scan-secrets.sh.tmpl`)
- Scans dotfiles source directory after every `chezmoi apply`
- Fails loudly if secrets detected in source files
- Prevents secrets from reaching git commits

**2. Daily Background Scan** (`trufflehog-daily-scan`)
- Runs once per 24 hours on shell startup
- Scans home directory locations where secrets accumulate
- Non-blocking background job, doesn't slow shell startup
- Only reports verified secrets (reduces false positives)

### Why TruffleHog?

Selected over alternatives (gitleaks, detect-secrets) because:
- Validates secrets by attempting authentication (800+ credential types)
- Actively maintained with regular detector updates
- Filesystem scanning mode works on non-git files
- Homebrew package available for easy installation

### Scope Limitations

**Chezmoi apply scan fails the operation** because:
- Source files should never contain secrets
- Early detection prevents git commits
- Explicit opt-in to override if needed

**Daily scan only warns** because:
- Home directory legitimately contains encrypted secrets (.ssh/, .gnupg/)
- Chezmoi-managed private files are intentional
- Goal is awareness, not enforcement

### Excluded Paths

Both scans exclude:
- `.git/` - Git internals, already scanned by pre-commit hooks
- `node_modules/` - Third-party code, not our responsibility
- `.cache/` - Temporary files, high noise ratio

## Trade-offs

### What We Don't Do

**Pre-commit hooks**: TruffleHog offers git hooks, but we use Lefthook for consistency. Future enhancement if needed.

**Real-time monitoring**: Considered filesystem watchers but rejected due to:
- Battery impact on laptops
- Complexity of setup
- Daily scans sufficient for personal dotfiles

**CI/CD integration**: Not applicable for dotfiles repo, but pattern supports future expansion.

### Performance Impact

- Chezmoi apply: Adds ~2-5 seconds to apply time (acceptable for security benefit)
- Shell startup: Zero impact (background job, disowned from shell)
- Disk I/O: Minimal, scans skip binary files automatically

## Sources

- [TruffleHog Documentation](https://github.com/trufflesecurity/trufflehog)
- [Chezmoi Hooks](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/)
- Inspired by pre-commit hook patterns in the security community
