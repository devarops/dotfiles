---
description: Capture session learnings, update documentation, and perform housekeeping before closing.
---

Before starting, verify a clean working tree with `git status --porcelain`; if any
uncommitted change exists, notify the user and stop.

## The public interface

Applies only when `DOCS.md` or `CHANGELOG.md` exists; otherwise skip it and do not ask
`AGENTS.md` for an interface.

Every entry in `DOCS.md` or `CHANGELOG.md` must belong to the public interface: the outermost
interface the end user consumes. The chain is: `AGENTS.md` defines the interface, `DOCS.md`
lists its current elements, and `CHANGELOG.md` records only changes that touched an element
listed in `DOCS.md`.

A change the end user cannot reach is not user-facing and belongs in neither file.
Developer-facing helpers, internal functions, code reachable only through internal code, and
behaviour-preserving refactors are excluded even when tests cover them. When a test is the
only evidence for a symbol, ask whether an end user can reach it; if not, leave it out.

If `AGENTS.md` lacks the definition, infer the criterion from the outermost entrypoints,
present it for approval, and record it once approved. Preserve it; revise only when the
criterion changes, not to reflect element changes. Keep the definition, `DOCS.md`, and
`CHANGELOG.md` in sync whenever elements are added, deprecated, or removed.

## File Registry

| File | Purpose | When |
| :--- | :--- | :--- |
| `AGENTS.md` | Internal guidelines; the interface definition when in use. | Always create or update |
| `DOCS.md` | Interface reference: every public-interface element. | Only if it exists |
| `CHANGELOG.md` | History of changes to elements in `DOCS.md` (SemVer, Keep a Changelog). | Only if it exists |
| `README.md` | Project overview and usage, for a non-technical audience. | Always create or update |
| `TODO.md` | Work in progress and backlog. | Only if it exists; create only on request |

The five files are complementary: each has one job and must not repeat another. In
particular, `README.md` must not overlap `AGENTS.md`, `DOCS.md`, or `CHANGELOG.md`.

---

## 1. Update AGENTS.md

Update or create `AGENTS.md`: a compact instruction file that helps future agents avoid
mistakes. When the section above applies, it also defines the public interface; otherwise,
guidelines only.

Identify the patterns, infrastructure, and workflow conventions this session revealed. Every
line should answer: is this new, and would an agent miss it? If not, omit it.

Read the strongest sources, in order:

- the tests, if any;
- otherwise the repo's verification: `Makefile` targets like `format` and `check`, plus lint,
  formatter, typecheck, and codegen config;
- CI workflows and pre-commit or task-runner config;
- `Makefile` and every root file;
- if unclear, the entrypoints, package boundaries, and execution flow.

Prefer executable sources over prose: where docs and config disagree, trust the executable
source and keep only what you can verify.

Record the high-signal facts:

- exact developer commands, especially non-obvious ones;
- how to run a single test, package, or focused verification step;
- required command order when it matters, such as `lint -> typecheck -> test`;
- monorepo boundaries, directory ownership, and the real app or library entrypoints;
- toolchain quirks: codegen, migrations, build artefacts, env loading, dev servers, deploy
  flow;
- conventions that differ from the defaults;
- testing quirks: fixtures, prerequisites, required services, or expensive suites;
- constraints from existing instruction files worth preserving.

Exclude generic advice, tutorials, exhaustive file trees, obvious language conventions,
unverifiable claims, and content better stored elsewhere.

When in doubt, omit. Prefer short sections and bullets: a simple repository gets a simple
file, a large one the few structural facts that matter.

If `AGENTS.md` exists, improve it in place: map findings to its sections, keep the tone,
preserve verified guidance, delete fluff and stale claims, and reconcile it with the
codebase. When the section above applies, preserve the interface definition unless the
criterion changed.

Keep `AGENTS.md` under 2,000 words; at 2,000, truncate to 1,000 by removing the
lowest-signal content.

A `---` boundary separates your content from the agent's. Do not add one if absent. If
present, never edit or remove it or anything below it, and exclude everything below it from
the word count.

Review: present the changes and explain. Do not commit yet.

## 2. Update DOCS.md (only if it exists)

If `DOCS.md` does not exist, skip this step and report that it was skipped.

Update the interface reference to list every public-interface element and nothing else.
Infer each from the interface: the tests when present, otherwise public entrypoints, exported
symbols, CLI definitions, and routes.

- Include only elements the end user can reach; never document internal functions, helpers,
  or developer-only utilities.
- Remove every entry whose element is no longer exposed. A discouraged element is marked
  Deprecated and stays until removed.
- Do not mention tests, testing strategy, or implementation details.

Format: every entry follows one of these shapes.

  ### symbol_name(signature)
  ### GET/POST /endpoint/
  ### cli command --options

  One-line description.

  - Parameters: name, type, description
  - Returns: type and description
  - Errors: exception/error types and triggering conditions (omit if none)
  - Notes: edge cases, constraints, side effects, or limitations (omit if none)

Review: present the changes and explain. Do not commit yet.

## 3. Update CHANGELOG.md (only if it exists)

If `CHANGELOG.md` does not exist, skip this step and report that it was skipped.

Update `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/). Include only
changes that touched an element listed in `DOCS.md`; a change no end user can reach is not an
entry.

- Version bump (SemVer):
  - MAJOR: incompatible changes.
  - MINOR: backward-compatible features added.
  - PATCH: backward-compatible bug fixes.
  - For 0.y.z versions, increment the MINOR for every release.

- Process:
  1. Audit tags: every changelog version has a tag (`vX.Y.Z`) and every tag appears in the
     changelog; resolve mismatches.
  2. Discover changes with `git diff <last_tag>..HEAD`. When tests exist, they are the
     preferred evidence; otherwise read the diff against the public interface.
  3. Consider only the topmost public-interface layer; ignore anything the end user cannot
     access.
  4. Categorise under `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.
  5. Add new changes to `## [Unreleased]`.
  6. Describe behaviour from the end user's perspective; one bullet per entry, code symbols
     in backticks.
  7. State the versions in which an element was deprecated and removed.

Review: present the changes and explain. Do not commit yet.

## 4. Update README.md

Rewrite or update `README.md` for a non-technical audience, with no overlap with `AGENTS.md`,
`DOCS.md`, or `CHANGELOG.md`.

- Constraints: no jargon, no implementation details, no algorithm explanations.
- Structure:
  1. Tagline: a phrase below the title explaining what it is.
  2. What it does: the problem this project solves.
  3. How to use it: the user journey through the public interface.
  4. Before you start: required installation, configuration, or credentials.
  5. Run the project: setup instructions (Docker preferred, then native).

Review: present the changes and explain. Do not commit yet.

## 5. Update TODO.md (only if it exists)

If `TODO.md` exists, clean it and add this session's future work.

Clean:
- Remove completed items (`[x]`).
- Remove items the current state confirms are done or obsolete, even if unmarked.

Discover future work from this session and the last eight commits
(`git log --patch --max-count 8`). Propose only with concrete evidence:

- a task the user declared out of scope;
- work the session left unfinished or was heading toward when it stopped;
- a gap the recent-commit diff makes visible.

Omit anything merely plausible. Before proposing, check the file: if it duplicates an open
item, do not propose it again and say it was already present.

Then, one candidate at a time: explain it and why it qualifies, and wait. Add it on approval,
discard it otherwise. Respect the file's structure and style: write into its own backlog
section; where it separates in-progress from backlog, put unfinished main-goal work in
in-progress and deferrals or sideline gaps in backlog. Never impose a template or add a
section the file lacks.

If `TODO.md` is absent, present the candidates and ask whether to create it; create it only on
approval, as a minimal `# Backlog` list.

Review: present the changes and explain. Do not commit yet.

## 6. Check interface consistency

Before committing, verify the chain is coherent and report any mismatch instead of leaving it
in place:

- every `DOCS.md` entry fits the interface definition in `AGENTS.md`, and every reachable
  element that fits it has an entry — verify against the interface, not a list in `AGENTS.md`,
  which holds none;
- every `CHANGELOG.md` entry touched an element listed in `DOCS.md`;
- no element that is no longer exposed remains in `DOCS.md`.

## 7. Commit and Tag

Ask the user to review and approve. Stop and wait. Once approved:

1. Stage the updated files.
2. Commit with a structured message: header `📝 Update documentation`, a blank second line,
   then a body summarising the key additions to each updated file.
3. Offer the user the option to undo the last commit.

## 8. Release a new version

Run only when `CHANGELOG.md` exists; otherwise skip and report it.

1. Verify the working tree is clean with `git status --porcelain`; if not, notify the user and
   stop.
2. Ask whether to release a new version. If not, stop here.
3. If so:
   - Move `## [Unreleased]` entries to a new version header with today's date.
   - Update the comparison links in the footer, commit the link changes, and run
     `git tag vX.Y.Z`.
   - Offer the user the option to undo the last commit, or to push the commit and tags.
4. Verify the working tree is clean with `git status --porcelain`.
