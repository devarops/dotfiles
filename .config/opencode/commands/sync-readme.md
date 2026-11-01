---
description: Bring README.md in line with the project for non-technical readers.
---

# Sync README.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Precondition

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- If `README.md` is absent, report and stop.
- The target is `<root>/README.md`. It must be clean: `git status --porcelain -- README.md` prints nothing.
- Do not require the rest of the tree to be clean.

## Update

- Update `README.md` for non-technical readers, without overlapping `AGENTS.md`, `DOCS.md`, or `CHANGELOG.md`.
- No jargon, implementation details, or algorithms.
- Structure: tagline; what it does; usage; before you start; run the project (Docker preferred, then native).
- Write only when the intended content differs. Do not stage or commit.

## Report

Report the sections changed and that nothing was staged or committed.

## Idempotency

The durable action is the write. Its precondition is that `README.md` differs from the intended content and is clean; after the write, the content matches and a second run writes nothing.
