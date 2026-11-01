---
description: Bring AGENTS.md in line with the session and the repository.
---

# Sync AGENTS.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Precondition

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- The target is `<root>/AGENTS.md`. It must be clean: `git status --porcelain -- AGENTS.md` prints nothing. An absent file is clean.
- Do not require the rest of the tree to be clean.

## Update

- If `AGENTS.md` is absent, create it.
- Add this session's learnings and the repository's patterns, conventions, and facts that `AGENTS.md` lacks and an agent would miss, without asking.
- Keep it compact: every line must be new and missed by an agent. Read tests; if none, read the repository's verification, root files, entrypoints, and execution flow. Prefer executable evidence; keep only verifiable facts.
- Record developer commands, command order, boundaries, entrypoints, toolchain quirks, conventions, and preserved constraints. Exclude generic advice, tutorials, obvious conventions, unverifiable claims, and better-placed content. When in doubt, omit; prefer bullets.
- Improve it in place: map findings to its sections, keep the tone, preserve verified guidance, and delete fluff and stale claims. Preserve the interface definition unless the criterion changes.
- Cap the file at 1,000 words by removing the lowest-signal content. Do not add a `---` boundary; if present, leave it and exclude everything below it from the count.
- List the numbered claims with nothing to check against. Search the repo, its history, and cited paths; drop any claim with an artifact to check against; omit doubtful cases; report none if empty. Quote each with its location, the artifact checked or absent, and why it is not checkable. Ask `Clarify: ...`; `Delete: ...`; `Ignore the rest.` Unnamed numbers are ignored; one correction. `Clarify` names a checkable artifact without changing meaning, or reports if impossible. `Delete` removes; the interface definition is never deleted.
- Write only when the intended content differs. Do not stage or commit.

## Report

Report the sections changed, the word count, each claim decision, and that nothing was staged or committed.

## Idempotency

The durable action is the write. Its precondition is that `AGENTS.md` differs from the intended content and is clean; after the write, the content matches and a second run writes nothing.
