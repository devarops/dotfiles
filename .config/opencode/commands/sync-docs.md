---
description: Bring DOCS.md in line with the public interface.
---

# Sync DOCS.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Precondition

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- If `DOCS.md` is absent, report and stop.
- The target is `<root>/DOCS.md`. It must be clean: `git status --porcelain -- DOCS.md` prints nothing.
- Do not require the rest of the tree to be clean.

## Update

- List every public-interface element and nothing else, inferred from tests, entrypoints, CLI definitions, and routes.
- Include only reachable elements; exclude internal elements, helpers, and developer-only utilities.
- Remove entries for elements no longer exposed; mark discouraged elements Deprecated until removed.
- Do not mention testing or implementation details.
- Entries use `### symbol_name(signature)`, `### GET/POST /endpoint/`, or `### cli command --options`; then a one-line description; Parameters, Returns, Errors (omit if none), Notes (omit if none).
- If `AGENTS.md` lacks the interface definition, report the gap and stop. `sync-agents` owns that definition.
- Write only when the intended content differs. Do not stage or commit.

## Report

Report the elements added, removed, deprecated, or changed, and that nothing was staged or committed.

## Idempotency

The durable action is the write. Its precondition is that `DOCS.md` differs from the intended content and is clean; after the write, the content matches and a second run writes nothing.
