---
description: Bring DESIGN.md's status table in line with the system and report prose drift.
---

# Sync DESIGN.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- If `DESIGN.md` is absent, ask once to create a minimal `# Design` with the `| Block | Status | Evidence |` header and its separator row. If the user declines, report and stop.
- The target is `<root>/DESIGN.md`. It must be clean: `git status --porcelain -- DESIGN.md` prints nothing. Do not require the rest of the tree to be clean.
- When `DOCS.md` or `CHANGELOG.md` exists, read `AGENTS.md` for the public interface. If it is absent or lacks the definition, report the gap and stop; `sync-agents` owns it.
- Read `DESIGN.md`, `TODO.md`, `specs/*.spec.toml`, and `tests/test_*.py` when they exist.

## Status table

- The table at the top is the index: `Block`, `Status`, `Evidence`.
- Each top-level section is one block, except `## Decisions and rejected alternatives`.
- `Status` is exactly `planned` or `built`.
- `Evidence` is one or more test nodes, spec criteria, or `manual:` entries.
- The table and the sections must match: every block has one row, and every row names a section.

## Check

Run the repository's unit tests once and, when `specs/` exists, its acceptance verification once. Use the same container convention as `sync-specs`: `docker exec ${PWD##*/}_dev make tests` and `docker exec ${PWD##*/}_dev make verify`. If the container is missing and the repository has no host target, report and stop. If a target is missing, skip it and report.

For each row in file order:

- **Automated evidence.** Resolve every test node and spec criterion. A test node passes only when its result is `passed`; a skip is not a pass. A spec criterion passes only when it is unskipped and its verify command passes.
- **Manual evidence.** Report `manual: <check>` and leave the row's status unchanged.
- **Built.** Set the row to `built` only when every automated item passes and no manual item is listed.
- **Planned.** Set the row to `planned` when any automated item fails, is skipped, is missing, or the row has no evidence. When there is no evidence, write `no artifact yet` in the evidence cell.
- **Regression.** When a row already says `built` and the check now fails, report it as a regression.

## Drift

Read each block's prose against the code and the tests. Report, without writing:

- a step, file, or module the block names that no longer exists;
- a code path that changes the order or a decision the block describes;
- a `TODO.md` item with no block;
- a block with no `TODO.md` item and no evidence, unless it is built;
- a block whose prose restates an observable criterion instead of linking to its spec.

Never rewrite the prose. Never resolve a disagreement between the code and the design.

## Write

Precondition: a row's `Status` or `Evidence` differs from the check. Replace only those cells. Preserve the prose, the table order, and every other line. Write only when the intended content differs. Do not stage or commit.

## Report

Report, in this order:

1. Rows set to `built`, with the evidence that passed.
2. Rows set to `planned`, with the failing, skipped, or missing evidence.
3. Manual checks left alone.
4. Regressions.
5. Drift findings.
6. Rows and sections that do not match.
7. Verification results.

State that the prose was not changed and that nothing was staged or committed.

## Idempotency

- The durable action is the status-table write.
- A write has the precondition that a row differs from the check; after the write, a second run writes nothing.
- The drift report is report-only and may repeat.
- When every row matches, a second run writes nothing.
