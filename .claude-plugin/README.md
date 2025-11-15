# Dotfiles Repository Plugins

This directory contains repository-specific Claude Code plugins for working with this dotfiles repository.

## Plugins

### Package Manager Agent

Specialized agent for managing package dependencies in this chezmoi-based dotfiles repository:

- Handles Homebrew, mise, Python, Docker, and chezmoi external dependencies
- Enforces immutable version pinning (versions, digests, SHAs)
- Maintains Renovate automation for automatic updates
- Prevents version drift and ensures reproducible builds

**When to use**: Any time you need to add, update, or remove packages or external dependencies.

### VCS (Jujutsu) Agent

Version control specialist for this repository:

- Creates atomic, well-described commits using Jujutsu (jj)
- Handles rebasing, squashing, and commit organization
- Prepares PR-ready commits
- Keeps version control operations separate from main agent context

**When to use**: When ready to commit changes or prepare pull requests.

### Chezmoi Package Management Skill

Comprehensive guidance for managing this chezmoi dotfiles repository:

- Package ecosystem selection (Homebrew vs mise vs Python vs Docker vs externals)
- Version pinning strategies
- `.chezmoiexternals/` organization patterns
- Renovate integration
- Platform-specific handling

**When to use**: When managing dotfiles structure, templates, or external dependencies.

## Usage in Claude Code

These plugins are automatically available when working in this repository. The main agent can invoke them as needed:

```
User: Add yq to our tools
Assistant: I'll invoke the Package Manager agent to handle this...
[Package Manager agent determines to use mise, pins version, updates manifests]
```

```
User: Let's commit these changes
Assistant: I'll hand off to the VCS agent to create PR-ready commits...
[VCS agent analyzes changes, creates atomic commits with proper messages]
```

## Marketplace Structure

The `marketplace.json` follows the Claude Code plugin marketplace specification and catalogs all repository-specific plugins.

## Relationship to Global Plugins

This marketplace is repository-specific and complements the global plugins installed via dotfiles:

- **Repository plugins** (`.claude-plugin/`): Only available when working in this repo
- **Global plugins** (`~/.claude-plugin/`): Available in all projects

Some plugins exist in both locations:
- VCS (Jujutsu) agent is available both globally and in this repo
- Chezmoi skill is repository-specific (only relevant for dotfiles management)

## References

- [Claude Code Plugin Marketplace Documentation](https://code.claude.com/docs/en/plugin-marketplaces)
- Project documentation: `CLAUDE.md`, `AGENTS.md`
