# Claude Code Plugin Marketplace

This directory contains the plugin marketplace configuration for personal Claude Code features distributed via dotfiles.

## What's Included

This marketplace catalogs all Claude Code extensions including:

### Agents (Specialized Subagents)

- **VCS (Jujutsu)**: Version control specialist for handling commit operations, rebases, and PR preparation using Jujutsu (jj)
- **PR Feedback Reviewer**: Analyzes pull request comments and provides prioritized recommendations
- **Reviewer**: Code quality and architecture reviewer (review-only, writes reports to scratch/)
- **Shell Wizard**: Production-quality shell script writer with safety headers and best practices

### Skills

- **use-jj-not-git**: Comprehensive Jujutsu (jj) guidance with command reference and workflow tutorials
- **skill-creator**: Meta-skill for creating new Claude Code skills with proper structure

### Commands

- **gitingest**: Generate comprehensive codebase digests for sharing repository context

## Installation

These plugins are automatically installed to `~/.claude-plugin/` when you apply your dotfiles with chezmoi:

```bash
chezmoi apply
```

## Marketplace Structure

The `marketplace.json` file follows the Claude Code plugin marketplace specification:

- **name**: Unique marketplace identifier
- **owner**: Marketplace maintainer information
- **metadata**: Description, version, and plugin root path
- **plugins**: Array of available plugins with metadata

### Plugin Entries

Each plugin entry includes:

- **name**: Unique plugin identifier (kebab-case)
- **source**: Path to plugin files (using `${CLAUDE_PLUGIN_ROOT}` variable)
- **description**: What the plugin does
- **version**: Semantic version
- **category**: Plugin category (version-control, code-review, scripting, etc.)
- **tags**: Searchable keywords
- **author**: Plugin author information
- **Component paths**: Specific paths to agents, skills, or commands

## Using Plugins

Once installed, plugins are automatically available in Claude Code:

### Agents

Agents appear as specialized subagents you can invoke from the main conversation:

- When working on version control tasks, the main agent can delegate to the VCS (Jujutsu) agent
- For PR review, invoke the PR Feedback Reviewer agent
- For code review, use the Reviewer agent
- For shell scripting, use the Shell Wizard agent

### Skills

Skills provide specialized knowledge and can be invoked when needed:

- Use the `use-jj-not-git` skill when working with Jujutsu version control
- Use the `skill-creator` skill when creating new skills

### Commands

Commands are slash commands available in the chat:

- `/gitingest` - Generate codebase digests

## Customization

You can modify the marketplace by editing:

- `home/dot_claude-plugin/marketplace.json` - Marketplace configuration
- Individual plugin files in `home/dot_claude/{agents,skills,commands}/`

After making changes, apply with:

```bash
chezmoi apply ~/.claude-plugin/
```

## Categories

Plugins are organized into the following categories:

- **version-control**: Git, Jujutsu, and VCS tools
- **code-review**: PR review, code quality, and architecture
- **scripting**: Shell scripting and automation
- **package-management**: Dependency and version management
- **development**: Development tools and meta-tools
- **utilities**: General utility commands

## Tags

Plugins can be searched by tags:

- `jujutsu`, `jj`, `vcs`, `git` - Version control
- `pr`, `review`, `feedback`, `github` - Code review
- `shell`, `bash`, `scripting`, `automation` - Shell scripting
- `packages`, `dependencies`, `renovate` - Package management
- `chezmoi`, `dotfiles` - Dotfiles management

## References

- [Claude Code Plugin Marketplace Documentation](https://code.claude.com/docs/en/plugin-marketplaces)
- [Claude Code Documentation](https://code.claude.com/docs/)

## Repository Structure

```
home/
├── dot_claude/
│   ├── agents/          # Specialized subagents
│   ├── skills/          # Knowledge bases
│   └── commands/        # Slash commands
└── dot_claude-plugin/
    ├── marketplace.json # Plugin marketplace catalog
    └── README.md       # This file
```

When installed via chezmoi, this becomes:

```
~/.claude/
├── agents/
├── skills/
└── commands/
~/.claude-plugin/
├── marketplace.json
└── README.md
```
