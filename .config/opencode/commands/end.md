---
description: Close the session by syncing the documentation and the verification plan.
---

Before starting, verify a clean tree with `git status --porcelain`; if dirty, notify and stop.

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Sync

Run these commands in order. Each reads `~/.config/opencode/documentation-contract.md` and follows it.

1. `sync-agents`
2. `sync-design`
3. `sync-docs`
4. `sync-changelog`
5. `sync-readme`
6. `sync-specs`
7. `sync-todo`

A missing optional file is not a failure; continue with the next command. Any other failure stops the close.

## Verify

Verify and report any mismatch.

`AGENTS.md` defines the public interface without listing its elements, and describes how to work in the repository without restating the design.
`DESIGN.md` describes the system as a workflow with one status row per block; every built row names passing evidence, and every planned row names the missing artifact or says `no artifact yet`.
`DOCS.md` lists all current public-interface elements and nothing else; it lists no planned element.
`CHANGELOG.md` records all changes to `DOCS.md` elements, and nothing else.
`TODO.md` is a flat ordered list; every item has a `Test:` line, and no item carries design detail.
`specs/*.spec.toml` holds observable criteria; no criterion is restated in `DESIGN.md` or `DOCS.md`.

## Hand off

Present and explain changes; ask the user to review, edit, and commit manually. Never stage or commit.
