# Documentation Contract

Shared rules for the six documentation files and the verification artifacts. Every `sync-*` command and `/end` reads this file.

## Public interface

Applies only when `DOCS.md` or `CHANGELOG.md` exists; otherwise skip it and do not ask for an interface.

Every entry belongs to the outermost interface the end user consumes. `AGENTS.md` defines it, `DOCS.md` lists its current elements, `CHANGELOG.md` records only changes to those elements, and `specs/*.spec.toml` holds the observable criteria. Exclude developer-only code and behaviour-preserving refactors; when only a test is evidence, ask whether the symbol is reachable; if not, omit it. If `AGENTS.md` lacks the definition, `sync-agents` infers it from the outermost entrypoints, presents it for approval, and records it. `sync-docs` and `sync-changelog` report the gap and stop. Preserve the definition unless the criterion changes. Sync the definition, `DOCS.md`, and `CHANGELOG.md` whenever elements are added, deprecated, or removed.

## Files

- `README.md` is the project overview for non-technical readers.
- `AGENTS.md` is the developer manual: environment setup, commands, gates, conventions, and the operational map. When the interface exists, it also defines it. It states what a developer must know to act and links to `DESIGN.md` for the system's shape.
- `DESIGN.md` is the system's workflow and design, written for programmers as a prose flowchart. It is the target before implementation and the description of what was built after. It owns mechanism and ordering; it links to `specs/*.spec.toml` for observable outcomes and to `DOCS.md` for the caller's view.
- `DOCS.md` lists every current public-interface element and nothing else. It never lists a planned element.
- `CHANGELOG.md` records changes to `DOCS.md` elements and nothing else.
- `TODO.md` is the backlog: a flat ordered list of `- [ ] <task>` items, each with a six-space `Test: <definition of done>` line. The list order is the build order. It holds no design detail and empties when the work is done.
- `specs/*.spec.toml` holds the acceptance criteria. Each criterion states one observable outcome through the public interface; a skipped criterion is planned behavior.

Files are complementary and must not overlap. Overlap is a repeated claim, not a shared subject: a stage may appear in `DESIGN.md` as mechanism, in `specs/` as an observable criterion, and in `DOCS.md` as a caller's view, provided each file states a different claim and links to the others. Do not add an entry another file covers, even if reworded. Review `AGENTS.md` and `README.md` on every run; write only when the intended content differs. Update `DESIGN.md`, `DOCS.md`, `CHANGELOG.md`, and `TODO.md` only if they exist. `sync-agents` creates an absent `AGENTS.md`; `sync-design` asks before creating an absent `DESIGN.md`; `sync-todo` asks before creating `TODO.md`; the other commands report a missing file and stop. `/end` continues with the remaining commands when a target is absent. `task-move` appends to the single `TODO.md` list and may create `# Backlog` when the file is absent; `sync-todo` adds selected items to the single list. No change is a success.

## DESIGN.md format

- A status table at the top is the index: one row per block, with `Block`, `Status`, and `Evidence` columns.
- `Status` is `planned` or `built`. No third state.
- `Evidence` is one or more of: a test node (`tests/test_foo.py::test_bar`), a spec criterion (`specs/foo.spec.toml` for every criterion in the file, or `specs/foo.spec.toml#3` for the third), or `manual: <check>`.
- A row is `built` only when every automated evidence item passes and no manual item is listed. A skipped, missing, or failing item makes it `planned`.
- Each top-level section is one block, except the closing `## Decisions and rejected alternatives` section. Each block carries its local rationale; the closing section carries the choices and rejected alternatives that span blocks.
- The prose describes the mechanism and ordering. It does not restate an observable criterion; it links to the spec.

## Verifiable claims

A claim is verifiable when the repo, its history, or a cited path has an artifact a reader can check, even by judgment or preference. A `built` row is verifiable when its evidence passes; a `planned` row names the missing artifact or says `no artifact yet`.

## Order

Run the commands in this order: `sync-agents`, `sync-design`, `sync-docs`, `sync-changelog`, `sync-readme`, `sync-specs`, `sync-todo`. A command may run alone mid-session; `/end` enforces the order.

## Clean rule

Each `sync-*` command requires its target files to be clean: `AGENTS.md`, `DESIGN.md`, `DOCS.md`, `CHANGELOG.md`, `README.md`, `TODO.md`, or, for `sync-specs`, `specs/` and `tests/` when they exist. It may run while other files are dirty. `sync-todo` accepts the `TODO.md` changes `sync-specs` made in the same `/end` run; otherwise it requires `TODO.md` clean. `/end` requires the whole tree to be clean before it starts. `sync-todo` checks `AGENTS.md` only when the user chooses an AGENTS fix. `task-move` is exempt because it inserts one item and preserves the rest of `TODO.md`.

## Commit rule

No command stages, commits, amends, or pushes. The user reviews and commits.
