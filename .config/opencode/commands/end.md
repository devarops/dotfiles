---
description: Close the session by syncing the documentation and verifying it.
---

Before starting, verify a clean tree with `git status --porcelain`; if dirty, notify and stop.

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Sync

Run these commands in order. Each reads `~/.config/opencode/documentation-contract.md` and follows it.

1. `sync-agents`
2. `sync-docs`
3. `sync-changelog`
4. `sync-readme`
5. `sync-todo`

A missing optional file is not a failure; continue with the next command. Any other failure stops the close.

## Verify

Verify and report any mismatch.

`AGENTS.md` defines the public interface without listing its elements.
`DOCS.md` lists all public-interface elements and nothing else.
`CHANGELOG.md` records all changes to `DOCS.md` elements, and nothing else.

## Hand off

Present and explain changes; ask the user to review, edit, and commit manually. Never stage or commit.
