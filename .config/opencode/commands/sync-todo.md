---
description: Update TODO.md and close the session open list.
---

# Sync TODO.md

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- The target is `<root>/TODO.md`. It must be clean: `git status --porcelain -- TODO.md` prints nothing. An absent file is clean.
- Do not require the rest of the tree to be clean.
- `AGENTS.md` must be clean only when the user chooses an AGENTS fix; check it at that moment.

## Purge the open list

- Follow the `task-purge` command first. It removes items whose `Test:` passes and asks about the ones it cannot evaluate.
- If `task-purge` reports a missing ignore rule or another defect, report and stop; do not delete `.OPEN.md`.
- If `.OPEN.md` is absent, continue with no open items.

## Audit AGENTS.md claims

- Audit every repo-visible claim in `AGENTS.md` against the repo (files, configs, commands, git history). Conduct rules need evidence of a violation. Cite the commit that introduced the divergence.
- Omit mismatches already tracked by an open `TODO.md` item.
- List the rest numbered: claim, location, evidence, cost of fixing each side.
- Ask `AGENTS: ...`; `TODO: ...`; `Ignore the rest.` Unnamed numbers are ignored; invalid placements get one correction. AGENTS fixes or removes the rule in `AGENTS.md`; TODO writes a future task to fix or remove the repo pattern; Ignore leaves both files unchanged.
- If the user chooses an AGENTS fix, check `AGENTS.md` clean first. If it is dirty, report and stop; do not write it.

## Create TODO.md

- If `TODO.md` is absent, ask once to create a minimal `# Backlog`.
- If declined, report the items and candidates without writing; continue to the close.

## Clean TODO.md

- Remove completed (`[x]`) and provably done or obsolete items, even if unmarked.

## Candidates

- Find gaps from this session and the last eight commits (`git log --patch --max-count 8`), with evidence: an out-of-scope task; a parked task; unfinished work; a recent-diff gap. Omit the merely plausible; if an open item duplicates it, skip it and say so.
- Include every remaining `.OPEN.md` item as a candidate; its evidence is its `Test:` line. Report an item without a `Test:` line as malformed; do not offer it as a candidate.
- Present all candidates numbered: task, evidence, why it qualifies. Wait. The user names the numbers to add; `all` means all. Unnamed candidates are not added. An invalid selection gets one correction.
- Write every new entry in the two-line format: `- [ ] <task>` followed by six spaces and `Test: <definition of done>`. Reuse the Test of an `.OPEN.md` candidate; use the evidence of any other candidate, or ask for a definition of done before writing.
- Add selected items to the best-fitting section. The two-line format is not a section template; never impose one or add a missing section. `task-move` may create its `# Backlog` fallback, but this command does not. Explain each placement.
- Remove duplicate and redundant `TODO.md` items, merging same-work items and keeping distinct tasks. Report every removal and merge.

## Close the open list

- Delete `.OPEN.md` and report every item not carried forward, including malformed items and when `TODO.md` was declined.
- Do not stage or commit.

## Report

Report the purged items, the AGENTS claim decisions, the TODO items added, removed, merged, and kept, the open items not carried forward, and that nothing was staged or committed.

## Idempotency

- The durable actions are the TODO.md write, the AGENTS.md fix, and the `.OPEN.md` deletion.
- The TODO write has the precondition that the intended content differs and `TODO.md` is clean; after the write, a second run writes nothing.
- The AGENTS fix has the precondition that `AGENTS.md` is clean and the rule still needs the change; after the write, a second run reports it as done.
- The deletion has the precondition that `.OPEN.md` exists; after the deletion, a second run reports no open list.
