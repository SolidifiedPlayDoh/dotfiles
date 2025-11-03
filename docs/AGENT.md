# Documentation Guidelines

## Purpose

Documentation in `docs/` captures **why** decisions were made, not **what** the code does. Amend documentation on changes when solving a problem.

## What to Include

- **Problem being solved**: What issue prompted the change?
- **Design decisions**: Why this approach over alternatives?
- **Sources**: What influenced the design? (links, references)
- **Trade-offs**: What was explicitly excluded or avoided?

## What to Exclude

- Feature documentation (that belongs in code comments or READMEs)
- Implementation details (code is self-documenting)
- Promotional language (this is just for me)
- Basic usage instructions (unless design-relevant)
- Redundant information available elsewhere (these aren't tool docs)

## Style

- Concise, technical markdown
- Get straight to the point
- Use lists and short paragraphs
- Code examples only when illustrating design choices

## Example: Good vs Bad

**Bad**: "Ghostty is a modern GPU-accelerated terminal emulator that provides excellent performance..."

**Good**: "Using `ctrl+s` prefix to avoid conflicts with tmux (`ctrl+b`, `ctrl+a`). Source: [gpakosz/.tmux](link)"

## Audience

These docs are for you, the repository owner. They help you (and AI assistants) understand the reasoning behind past decisions when making future changes.
