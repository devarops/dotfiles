---
description: Record committed public-interface changes in CHANGELOG.md.
---

# Sync CHANGELOG.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Precondition

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- If `CHANGELOG.md` is absent, report and stop.
- The target is `<root>/CHANGELOG.md`. It must be clean: `git status --porcelain -- CHANGELOG.md` prints nothing. If it is dirty, report and stop.
- If `DOCS.md` is absent, report and stop; the changelog records only its elements.
- If `AGENTS.md` lacks the interface definition, report the gap and stop. `sync-agents` owns that definition.
- The rest of the tree may be dirty. Report every dirty path that `HEAD` does not include and do not record it.

## Update

- Follow [Keep a Changelog](https://keepachangelog.com/). Include only changes to a `DOCS.md` element.
- Use `git diff <last_tag>..HEAD`. If there is no tag, use `git diff $(git hash-object -t tree /dev/null)..HEAD`.
- Prefer tests as evidence; otherwise read the diff. Categorize under Added, Changed, Deprecated, Removed, Fixed, Security.
- Add to `## [Unreleased]` unless the entry covers the change. Describe end-user behaviour, one bullet per entry, code symbols in backticks. State deprecation and removal versions.
- Write only when the intended content differs. Do not stage or commit.

## Report

Report the range, the entries added or changed, the uncommitted files omitted, and that nothing was staged or committed.

## Idempotency

The durable action is the write. Its precondition is that `CHANGELOG.md` differs from the intended content and is clean; after the write, a second run writes nothing for the same range.
