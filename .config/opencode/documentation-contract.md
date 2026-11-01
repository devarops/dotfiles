# Documentation Contract

Shared rules for the five documentation files. Every `sync-*` command and `/end` reads this file.

## Public interface

Applies only when `DOCS.md` or `CHANGELOG.md` exists; otherwise skip it and do not ask for an interface.

Every entry belongs to the outermost interface the end user consumes. `AGENTS.md` defines it, `DOCS.md` lists its elements, and `CHANGELOG.md` records only changes to those elements. Exclude developer-only code and behaviour-preserving refactors; when only a test is evidence, ask whether the symbol is reachable; if not, omit it. If `AGENTS.md` lacks the definition, `sync-agents` infers it from the outermost entrypoints, presents it for approval, and records it. `sync-docs` and `sync-changelog` report the gap and stop. Preserve the definition unless the criterion changes. Sync the definition, `DOCS.md`, and `CHANGELOG.md` whenever elements are added, deprecated, or removed.

## Files

- `README.md` is the project overview for non-technical readers.
- `AGENTS.md` is the repository guide and, when the interface exists, its definition.
- `DOCS.md` lists every public-interface element and nothing else.
- `CHANGELOG.md` records changes to `DOCS.md` elements and nothing else.
- `TODO.md` is the backlog.

Files are complementary and must not overlap; do not add an entry another file covers, even if reworded. Review `AGENTS.md` and `README.md` on every run; write only when the intended content differs. Update `DOCS.md`, `CHANGELOG.md`, and `TODO.md` only if they exist. `sync-agents` creates an absent `AGENTS.md`; `sync-todo` asks before creating `TODO.md`; the other commands report a missing file and stop. `/end` continues with the remaining commands when a target is absent. No change is a success.

## Verifiable claims

A claim is verifiable when the repo, its history, or a cited path has an artifact a reader can check, even by judgment or preference.

## Order

Run the commands in this order: `sync-agents`, `sync-docs`, `sync-changelog`, `sync-readme`, `sync-todo`. A command may run alone mid-session; `/end` enforces the order.

## Clean rule

Each `sync-*` command requires its target file to be clean: `AGENTS.md`, `DOCS.md`, `CHANGELOG.md`, `README.md`, or `TODO.md`. It may run while other files are dirty. `/end` requires the whole tree to be clean before it starts. `sync-todo` checks `AGENTS.md` only when the user chooses an AGENTS fix.

## Commit rule

No command stages, commits, amends, or pushes. The user reviews and commits.
