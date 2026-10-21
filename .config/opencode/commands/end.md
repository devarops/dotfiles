---
description: Capture session learnings, update documentation, and perform housekeeping before closing.
---

Before starting, verify a clean tree with `git status --porcelain`; if dirty, notify the user and stop.

## The public interface

Applies only when `DOCS.md` or `CHANGELOG.md` exists; otherwise skip it; do not ask for an interface.

Every entry must belong to the public interface, the outermost one the end user consumes. `AGENTS.md` defines it, `DOCS.md` lists its elements, and `CHANGELOG.md` records only changes to those elements. Exclude unreachable changes: developer-only code and behaviour-preserving refactors, even when tests cover them; when a test is the only evidence, ask whether the symbol is reachable; if not, omit it. If `AGENTS.md` lacks the definition, infer it from the outermost entrypoints, present it for approval, and record it. Preserve it; revise only when the criterion changes. Sync the definition, `DOCS.md`, and `CHANGELOG.md` whenever elements are added, deprecated, or removed.

## Files

Review `AGENTS.md` (guidelines; the interface definition when in use) and `README.md` on every run, and write only when the intended content differs from the current file. Update `DOCS.md`, `CHANGELOG.md`, and `TODO.md` only if they exist; create `TODO.md` only after confirmation. Report missing files. Files are complementary; `README.md` must not overlap them.

---

## 1. Update AGENTS.md

If `AGENTS.md` exists, audit every repo-visible claim in the file against the repo (files, configs, commands, git history). Conduct rules need evidence of a violation. Check all claims; cite the commit that introduced the divergence. Omit mismatches already tracked by an open `TODO.md` item.

List the rest numbered: claim, location, evidence, cost of fixing `AGENTS.md` versus the repo.

Ask for an answer in the form: `AGENTS: ...`; `TODO: ...`; `Ignore the rest.` Unnamed numbers are ignored; invalid placements get one correction. AGENTS fixes or removes the rule in `AGENTS.md`; TODO writes a future task in `TODO.md` to fix or remove the repo pattern; Ignore leaves both files unchanged.

Write assigned `TODO.md` items immediately into the best-fitting section. If `TODO.md` is absent, ask whether to create; on confirmation, create a minimal `# Backlog` with them. If declined, report; do not ask again.

If `AGENTS.md` was absent, create it and skip the triage. Add this session's learnings and the repo's patterns, conventions, and facts that `AGENTS.md` lacks and an agent would miss—without asking. Never duplicate an explicit rule, add one on a triaged subject, or add a conflicting one; conflicts belong in the list.

Keep `AGENTS.md` compact: every line must be new and missed by an agent; if not, omit. Read tests; if none, read the repo's verification (`Makefile`, lint, typecheck, codegen, CI, pre-commit), root files, entrypoints, and execution flow. Prefer executable evidence; keep only what you can verify; it never decides a conflict.

Record developer commands, focused checks, command order, boundaries, entrypoints, toolchain quirks, conventions, testing quirks, and preserved constraints. Exclude generic advice, tutorials, exhaustive trees, obvious conventions, unverifiable claims, and better-placed content. When in doubt, omit; prefer bullets.

Improve it in place: map findings to its sections, keep the tone, preserve verified guidance, delete fluff and stale claims. Preserve the interface definition unless the criterion changes. Cap it at 1,000 words by removing the lowest-signal content. Do not add a `---` boundary; if present, leave it and exclude everything below it from the count.

## 2. Update DOCS.md

List every public-interface element and nothing else, inferred from tests, entrypoints, CLI definitions, and routes. Include only reachable elements; exclude internal functions, helpers, and developer-only utilities. Remove entries for elements no longer exposed; mark discouraged elements Deprecated until removed. Do not mention testing or implementation details.

Entries use `### symbol_name(signature)`, `### GET/POST /endpoint/`, or `### cli command --options`; then one-line description; Parameters, Returns, Errors (omit if none), Notes (omit if none).

## 3. Update CHANGELOG.md

Follow [Keep a Changelog](https://keepachangelog.com/). Include only changes to a `DOCS.md` element. Discover with `git diff <last_tag>..HEAD`; prefer tests; otherwise, read the diff against the interface. Categorise under Added, Changed, Deprecated, Removed, Fixed, Security; add to `## [Unreleased]`. Describe end-user behaviour, one bullet per entry, code symbols in backticks. State the versions of deprecation and removal.

## 4. Update README.md

Update `README.md` for non-technical readers, with no overlap with `AGENTS.md`, `DOCS.md`, or `CHANGELOG.md`; no jargon, implementation details, or algorithms. Structure: tagline; what it does; usage; before you start; run the project (Docker preferred, then native).

## 5. Update TODO.md

Clean `TODO.md`: remove completed items (`[x]`) and items the current state proves done or obsolete, even if unmarked.

Find gaps from this session and the last eight commits (`git log --patch --max-count 8`), with evidence: an out-of-scope task; a parked task; unfinished work; a gap in the recent diff. Omit the merely plausible; if an open item duplicates it, skip it and say so.

Present all candidates numbered: task, evidence, why it qualifies. Wait. The user names the numbers to add; `all` means all. Unnamed candidates are not added. An invalid selection gets one correction.

Add selected items to the best-fitting section. Never impose a template or add a missing section; explain each placement. If `TODO.md` is absent, present the candidates, ask once whether to create, and create only on approval as a minimal `# Backlog`. If creation was declined, report instead.

## 6. Verify and tidy

Verify and report any mismatch.

`AGENTS.md` defines the public interface without listing its elements.
`DOCS.md` lists all public-interface elements and nothing else.
`CHANGELOG.md` records all changes to `DOCS.md` elements, and nothing else.

Then list numbered `AGENTS.md` claims with ambiguous or vague phrasing: quote, location, why uncheckable. Ask for an answer in the form `Clarify: ...`; `Delete: ...`; `Ignore the rest.` Unnamed numbers are ignored; invalid replies get one correction. `Clarify` rewrites only enough to be checkable without changing meaning, or leaves it and reports if impossible. `Delete` removes; the interface definition is never deleted.

Finally, remove duplicate and redundant `TODO.md` items, merging same-work items and keeping distinct tasks. Report every removal and merge.

## 7. Hand off

Present and explain changes; ask the user to review, edit, and commit manually. Never stage or commit.
