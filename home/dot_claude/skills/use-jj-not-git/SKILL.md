---
name: use-jj-not-git
description: Expert guidance for using Jujutsu (jj), a modern version control system. Use this skill when you would use git, users ask about jj commands, need help with jj concepts (working copy, changes, conflicts, operation log, bookmarks, revsets), troubleshoot jj issues, configure jj settings, understand jj workflows, translate Git commands to jj, or work with jj repositories. Also trigger when users mention "jujutsu", "jj command", version control, or commit management.
---

# Jujutsu (jj) Expert Guide

## Core Mental Model

Jujutsu's design differs fundamentally from Git in key ways:

### Automatic Working Copy Commits

- Every change in the working copy is automatically committed
- No staging area/index - changes are immediately tracked
- Use `jj commit` to finalize and start a new change (like Git's `git commit`)
- Working copy state is preserved in the operation log

### Changes vs Commits

- **Change ID**: Stable identifier that persists across rewrites
- **Commit ID**: Traditional hash that changes when content changes
- Changes can evolve while keeping the same Change ID
- Use Change IDs for referring to logical changes, Commit IDs for exact snapshots

### No Current Branch

- Jujutsu has no concept of "checked out branch"
- Bookmarks (branches) must be manually updated
- Working copy is always on an anonymous commit
- Bookmarks track important commits but don't move automatically

### First-Class Conflicts

- Conflicts can be committed and kept in history
- Rebase doesn't stop on conflicts - they're recorded in commits
- Conflicts can be resolved later or rebased further
- No `--continue` needed - operations are atomic

### Operation Log

- Every operation is recorded (like a super-powered reflog)
- `jj undo` reverses the last operation
- `jj op log` shows full history of repository operations
- Operations enable lock-free concurrency

## Common Workflows

### Starting Work

```bash
# Create new change on top of main
jj new main

# Start describing your work
jj describe -m "feat: add new feature"

# Make changes (files are auto-tracked)
# No need for 'git add'

# Finalize this change and start a new one
jj commit
```

### Amending Changes

```bash
# Make more changes to current commit
# Just edit files - they're automatically amended

# Or explicitly squash changes into parent
jj squash

# Or interactively move parts to parent
jj squash -i
```

### Working with Bookmarks

```bash
# List bookmarks
jj bookmark list

# Create bookmark at current change
jj bookmark create my-feature

# Move bookmark to different change
jj bookmark move my-feature --to @

# Push bookmark to remote
jj git push --bookmark my-feature

# Or let jj auto-generate bookmark name
jj git push --change @
```

### Resolving Conflicts

```bash
# Conflicts don't block operations
# They're recorded in commits marked with ×

# Create new commit on top to resolve
jj new <conflicted-change>
# Edit files to resolve conflicts
jj squash  # Move resolution into conflicted commit

# Or edit the conflicted commit directly
jj edit <conflicted-change>
# Resolve conflicts
jj commit  # Finalize the resolution
```

### Rebasing and Rewriting

```bash
# Rebase current change onto main
jj rebase -d main

# Rebase a specific change and descendants
jj rebase -s <change-id> -d <destination>

# Rebase before a specific change
jj rebase -r <change> --before <target>

# All descendants auto-rebase
```

### Viewing History

```bash
# Default view (working copy ancestors + recent)
jj log

# All commits
jj log -r 'all()'

# Commits not in main
jj log -r 'main..'

# Your commits
jj log -r 'mine()'

# Specific revision
jj show <change-id>
```

## Git Command Translation

For quick reference, common translations:

| Git Command             | Jujutsu Command                         | Notes                       |
| ----------------------- | --------------------------------------- | --------------------------- |
| `git add`               | (automatic)                             | Files auto-tracked          |
| `git commit`            | `jj commit`                             | Finalizes current change    |
| `git commit --amend`    | `jj describe` or edit files             | Auto-amends working copy    |
| `git checkout <branch>` | `jj new <bookmark>`                     | Creates new change on top   |
| `git rebase -i`         | `jj rebase`, `jj squash -i`, `jj split` | Multiple commands           |
| `git status`            | `jj st`                                 | Shows working copy changes  |
| `git log`               | `jj log`                                | Better defaults             |
| `git branch`            | `jj bookmark list`                      | Bookmarks not branches      |
| `git push`              | `jj git push`                           | Explicit Git integration    |
| `git fetch`             | `jj git fetch`                          | Explicit Git integration    |
| `git stash`             | `jj new @-`                             | Old commit stays as sibling |

See `references/git-to-jj-commands.md` for comprehensive mapping.

## Key Concepts

### Revsets

- Query language for selecting commits
- `@` = working copy, `@-` = parent, `@+` = children
- `::@` = ancestors, `@::` = descendants
- `main..@` = commits between main and working copy
- `mine()` = your commits, `author()` = by author
- `description()` = by commit message
- See `references/revsets.md` for full syntax.

### Bookmarks

- Named pointers to commits (like Git branches)
- Must be manually updated (don't track working copy)
- Can track remote bookmarks
- Use `jj bookmark track` to sync with remotes
- See `references/bookmarks.md` for details.

### Working Copy

- Always represents an actual commit
- Changes auto-committed on every `jj` command
- Files auto-tracked (respects .gitignore)
- Use `jj file untrack` to stop tracking
- See `references/working-copy.md` for details.

### Operations

- Atomic transactions of repository changes
- Enable `jj undo` for any operation
- Power features like lock-free concurrency
- View with `jj op log`
- See `references/operation-log.md` for details.

## Configuration

### Essential Config

```toml
[user]
name = "Your Name"
email = "you@example.com"

[ui]
# Use built-in diff editor
diff-editor = ":builtin"

# Or use external tool
# diff-editor = "meld"

# Default to relative timestamps
[template-aliases]
'format_timestamp(timestamp)' = 'timestamp.ago()'
```

See `references/config.md` for comprehensive configuration options.

## Troubleshooting

### Divergent Changes

When multiple commits have same Change ID:

- Use `jj log` to see which commits are divergent (marked with `??`)
- Choose strategy: abandon one, duplicate+abandon, squash together
- See `references/divergence.md` for detailed resolution strategies

### Stale Working Copy

When working copy doesn't match latest operation:

```bash
jj workspace update-stale
```

### Push Failures

- Ensure bookmark is tracked: `jj bookmark track <bookmark>@<remote>`
- Check for conflicts: `jj bookmark list` shows `??` for conflicts
- Resolve conflicts before pushing

## GitHub Workflows

### Fork-Based Contribution

```bash
# Clone from upstream
jj git clone https://github.com/upstream/repo

# Add your fork
jj git remote add origin git@github.com:you/repo

# Configure remotes
jj config set --repo git.fetch '["upstream", "origin"]'
jj config set --repo git.push origin

# Track both bookmarks
jj bookmark track main@upstream main@origin

# Set trunk
jj config set --repo 'revset-aliases."trunk()"' main@upstream

# Normal workflow
jj new main
# make changes
jj commit -m "feat: add feature"
jj git push --change @-
```

See `references/github.md` for comprehensive GitHub workflows.

## Advanced Features

### Splitting Commits

```bash
jj split  # Interactively split current change
jj split -r <change>  # Split any change
```

### Interactive Squashing

```bash
jj squash -i  # Choose which changes to move to parent
jj squash -i --from <source> --into <dest>  # Between any commits
```

### Conflict Resolution

```bash
jj resolve  # Use external merge tool
# Or manually edit conflict markers
# Then jj squash to move resolution into conflicted commit
```

### Multiple Workspaces

```bash
jj workspace add ../other-workspace
jj workspace list
jj workspace forget <workspace>
```

## When to Read References

- **Git migration**: Read `references/git-to-jj-commands.md` for comprehensive command mapping
- **Revset queries**: Read `references/revsets.md` for full syntax and examples
- **Configuration**: Read `references/config.md` for all settings
- **Conflicts**: Read `references/conflicts.md` for conflict resolution strategies
- **Bookmarks**: Read `references/bookmarks.md` for bookmark management
- **GitHub workflows**: Read `references/github.md` for fork/PR workflows
- **Working copy behavior**: Read `references/working-copy.md` for details
- **Operation log**: Read `references/operation-log.md` for operation management
- **Divergence**: Read `references/divergence.md` for handling divergent changes
- **Multiple remotes**: Read `references/multiple-remotes.md` for multi-remote setups
- **Git compatibility**: Read `references/git-compatibility.md` for colocated repos and Git interop

## Quick Tips

- Always use Change IDs (not Commit IDs) when referring to changes
- `jj undo` is your friend - operations are reversible
- Conflicts are not errors - they can be committed
- No staging area means no `git add` - files are auto-tracked
- Bookmarks don't move automatically - update them manually
- Use `jj log` liberally to understand repository state
- `@` is working copy, `@-` is parent, `@+` is children
- Descendants auto-rebase when you rewrite commits
