---
name: use-jj-not-git
description: Guidance for using Jujutsu (jj) for version control. Use this skill when you would use git in order to make and edit commits properly, or for help to understand jj commands or concepts (working copy, changes, conflicts, operation log, bookmarks, revsets), troubleshoot jj issues, configure jj settings, understand jj workflows, translate Git commands to jj, or work with jj repositories. Also trigger when users mention "jujutsu", version control, or commits.
---

# Jujutsu (jj) Expert Guide

## What Makes jj Different

**No staging area** - Files are automatically tracked and changes auto-commit to your working copy. Just edit and run `jj commit` when ready.

**Change IDs persist** - Unlike Git's commit hashes that change on rewrite, jj's Change IDs stay stable across rebases and amendments.

**Bookmarks don't move** - There's no "checked out branch." Bookmarks are pointers you manually update with `jj bookmark move`.

**Conflicts are first-class** - Operations never stop on conflicts. They're recorded in commits (marked `×`) and can be resolved later.

**`jj undo` everything** - Every operation is recorded in the operation log and can be undone.

## Common Commands (One-Shot Examples)

### Starting new work

```bash
# Create new change on main, make changes, commit
jj new main && jj describe -m "feat: add feature" && \
  # ... edit files ... && \
  jj commit
```

### Amending the current change

```bash
# Just edit files - they automatically amend
# Or interactively select changes to move to parent
jj squash -i
```

### Push to GitHub

```bash
# Auto-create bookmark and push
jj git push --change @

# Or push specific bookmark
jj git push --bookmark my-feature
```

### Quick rebase

```bash
# Rebase current change onto main
jj rebase -d main
```

### View what's happening

```bash
jj log              # See recent history
jj st               # See working copy changes
jj log -r 'mine()'  # See your commits
```

## Git Command Quick Reference

| Git                     | Jujutsu                    | Notes                    |
| ----------------------- | -------------------------- | ------------------------ |
| `git add`               | (automatic)                | Files auto-tracked       |
| `git commit`            | `jj commit`                | Finalizes current change |
| `git commit --amend`    | edit files                 | Auto-amends working copy |
| `git checkout <branch>` | `jj new <bookmark>`        | Creates new change on top|
| `git rebase -i`         | `jj rebase`/`squash`/`split` | Multiple commands     |
| `git status`            | `jj st`                    | Working copy changes     |
| `git log`               | `jj log`                   | Better defaults          |
| `git branch`            | `jj bookmark list`         | Bookmarks not branches   |
| `git push`              | `jj git push`              | Explicit Git integration |
| `git stash`             | `jj new @-`                | Old commit stays as sibling |

## Essential Revset Syntax

- `@` = working copy
- `@-` = parent, `@+` = children
- `main..@` = commits between main and working copy
- `mine()` = your commits
- `all()` = all commits

**For full revset syntax:** See `references/revsets.md`

## When to Read References

Detailed documentation in `references/`:

- **`git-to-jj-commands.md`** - Comprehensive Git → jj command mapping
- **`tutorial.md`** - Step-by-step introduction
- **`working-copy.md`** - How automatic commits work
- **`bookmarks.md`** - Managing bookmarks and remotes
- **`conflicts.md`** - Conflict resolution strategies
- **`operation-log.md`** - Using `jj undo` and operation history
- **`github.md`** - Fork workflows and PRs
- **`config.md`** - All configuration options
- **`revsets.md`** - Full query syntax
- **`divergence.md`** - Handling divergent changes
- **`multiple-remotes.md`** - Multi-remote setups
- **`git-compatibility.md`** - Colocated repos and Git interop

## Quick Tips

- Use Change IDs (not commit hashes) when referring to changes
- `jj undo` is your friend - all operations are reversible
- Files are auto-tracked (respects `.gitignore`)
- Descendants automatically rebase when you rewrite commits
- Use `jj log` frequently to understand repository state
