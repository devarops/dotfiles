---
description: Capture session learnings, update documentation, and perform housekeeping before closing.
---

Before starting, use `git status --porcelain` to verify that the working tree is clean.
If any uncommitted change exists, notify the user and stop immediately.

## The external surface

Every entry you write to `DOCS.md` or `CHANGELOG.md` must belong to the repository's
external surface: the outermost interface the end user consumes. The chain is:

- `AGENTS.md` defines the surface: it states the criterion for what counts as user-facing,
  but it does not list the elements. The definition changes rarely.
- `DOCS.md` lists the current elements that satisfy that definition. It is a snapshot.
- `CHANGELOG.md` records only changes that touched an element listed in `DOCS.md`. It is a
  history.

A change the end user cannot reach through the surface is not user-facing and belongs in
neither file. Developer-facing helpers, internal functions, code reachable only through
internal code, and behaviour-preserving refactors are excluded even when tests cover them.
When a test is the only evidence for a symbol, ask whether an end user can reach that
symbol; if not, leave it out.

If `AGENTS.md` does not define the surface, infer the criterion from the outermost
entrypoints, present it for approval, and record it in `AGENTS.md` once approved. Preserve
the definition as written: revise it only when the criterion itself changes, not to reflect
changes to the elements. Keep the definition, `DOCS.md`, and `CHANGELOG.md` in sync whenever
elements are added, deprecated, or removed.

## File Registry

| File | Purpose | Audience | When |
| :--- | :--- | :--- | :--- |
| `AGENTS.md` | Defines the external surface and holds internal guidelines, patterns, and conventions. | Maintainers | Always create or update |
| `DOCS.md` | Interface reference: every element of the external surface, current state. | End users | Only if it exists |
| `CHANGELOG.md` | History of changes to elements in `DOCS.md`, following SemVer and Keep a Changelog. | End users | Only if it exists |
| `README.md` | High-level project overview and usage. | End users | Always create or update |
| `TODO.md` | Work in progress and backlog: completed items are cleaned, and future work found this session is added. | Maintainers | Only if it exists; create only on request |

The five files are complementary: each has one job and must not repeat another. In
particular, `README.md` must not overlap `AGENTS.md`, `DOCS.md`, or `CHANGELOG.md`.

---

## 1. Update AGENTS.md

Update or create `AGENTS.md`: a compact instruction file that helps future AI agents avoid
mistakes and ramp up quickly, and that defines the repository's external surface.

Identify the patterns, infrastructure, and workflow conventions that emerged this session.
Every line should answer: what did you learn that is not yet documented, and would an agent
likely miss it without help? If not, leave it out.

Read the strongest sources that exist, in this order:

- the tests, when the repository has them;
- otherwise the repo's real verification: `Makefile` targets such as `format` and `check`,
  plus lint, formatter, typecheck, and codegen config;
- CI workflows and pre-commit or task-runner config;
- `Makefile` and every file at the root;
- if architecture is still unclear, the entrypoints, package boundaries, and execution flow.

Prefer executable sources of truth over prose. Where docs and config disagree, trust the
executable source and keep only what you can verify.

High-signal facts to record:

- exact developer commands, especially non-obvious ones;
- how to run a single test, a single package, or a focused verification step;
- required command order when it matters, such as `lint -> typecheck -> test`;
- monorepo or multi-package boundaries, ownership of major directories, and the real
  app or library entrypoints;
- toolchain quirks: generated code, migrations, codegen, build artefacts, env loading,
  dev servers, deploy flow;
- conventions that differ from the defaults;
- testing quirks: fixtures, prerequisites, required services, or expensive suites;
- constraints from existing instruction files worth preserving.

Exclude generic software advice, tutorials and exhaustive file trees, obvious language
conventions, anything you could not verify, and content better stored elsewhere and
referenced.

When in doubt, omit. Prefer short sections and bullets. A simple repository gets a simple
file; a large one gets the few structural facts that change how an agent works.

If `AGENTS.md` already exists, improve it in place: map findings to its existing sections,
keep the tone, preserve verified guidance, delete fluff and stale claims, and reconcile it
with the current codebase. Preserve the external-surface definition unless the criterion
itself has changed; it is expected to be stable.

Keep `AGENTS.md` under 2,000 words. If it reaches 2,000, truncate it to 1,000 by removing
the lowest-signal content.

A `---` boundary separates the content you maintain from the content the agent maintains. Do
not add one if it does not exist. If one exists, never edit or remove it or anything below
it, and exclude everything below it from the word count.

Review: present the changes and explain. Do not commit yet.

## 2. Update DOCS.md (only if it exists)

If `DOCS.md` does not exist, skip this step and report that it was skipped.

Update the interface reference so that it lists every element of the external surface and
nothing else. Infer each element from the interface: the tests when the repo has them,
otherwise the public entrypoints, exported symbols, CLI definitions, and routes.

- Include only elements the end user can reach through the external surface. Never document
  internal functions, helpers, or developer-only utilities.
- Remove every entry whose element is no longer exposed. An element that still exists but is
  discouraged is marked Deprecated; it stays until it is removed.
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

Update `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/). Include
only changes that touched an element listed in `DOCS.md`; a change no end user can reach
through the surface is not an entry.

- Version bump (SemVer):
  - MAJOR: incompatible changes.
  - MINOR: backward-compatible features added.
  - PATCH: backward-compatible bug fixes.
  - For 0.y.z versions, increment the MINOR for every release.

- Process:
  1. Audit tags: every changelog version has a tag (`vX.Y.Z`) and every tag appears in the
     changelog; resolve mismatches.
  2. Discover changes with `git diff <last_tag>..HEAD` over the whole tree. When tests
     exist, they are the preferred evidence for what changed; otherwise read the diff
     against the external surface.
  3. Consider only the topmost external layer; ignore anything the end user cannot access.
  4. Categorise under `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.
  5. Add new changes to `## [Unreleased]`.
  6. Describe behaviour from the end user's perspective; one bullet per entry, code symbols
     in backticks.
  7. State the version in which an element was deprecated and the version in which it was
     removed.

Review: present the changes and explain. Do not commit yet.

## 4. Update README.md

Rewrite or update `README.md` for a non-technical audience, with no overlap with `AGENTS.md`,
`DOCS.md`, or `CHANGELOG.md`.

- Constraints: no jargon, no implementation details, no algorithm explanations.
- Structure:
  1. Tagline: a memorable phrase below the title explaining what it is.
  2. What it does: the problem this project solves.
  3. How to use it: the user journey through the external surface.
  4. Before you start: required installation, configuration, or credentials.
  5. Run the project: setup instructions (Docker preferred, then native).

Review: present the changes and explain. Do not commit yet.

## 5. Update TODO.md (only if it exists)

If `TODO.md` exists, clean it and add the future work this session produced.

Clean:
- Remove completed items (`[x]`).
- Remove items the current state confirms are done or obsolete, even if unmarked.

Discover future work. Look only at what this session revealed and at what the last eight
commits show (`git log --patch --max-count 8`). Propose a candidate only with concrete
evidence:

- a task the user declared out of scope for this session;
- work the session left unfinished, or the direction it was heading when it stopped;
- a gap the recent-commit diff makes visible.

Omit anything merely plausible. Before proposing a candidate, check the file: if it
duplicates an existing open item, do not propose it again, and say it was already present.

Then, one candidate at a time: explain the item and why it qualifies, and wait. Add it when
the user approves and discard it when they do not. Respect the file's existing structure and
style: write into its own backlog section, and where the file separates in-progress from
backlog, put unfinished main-goal work in the in-progress section and deferrals or sideline
gaps in the backlog. Never impose a template or add a section the file does not have.

If `TODO.md` does not exist, present the candidates and ask whether to create it. Create it
only on approval, as a minimal `# Backlog` list.

Review: present the changes and explain. Do not commit yet.

## 6. Check surface consistency

Before committing, verify the chain is coherent and report any mismatch instead of leaving
it in place:

- every entry in `DOCS.md` fits the definition of the external surface in `AGENTS.md`, and
  every element that fits that definition and is reachable has an entry — verify against the
  surface itself, never against a list in `AGENTS.md`, which does not hold one;
- every entry in `CHANGELOG.md` touched an element listed in `DOCS.md`;
- no element that is no longer exposed remains in `DOCS.md`.

## 7. Commit and Tag

Ask the user to review and approve the changes. Stop and wait for approval. Once approved:

1. Stage the updated files.
2. Commit with a structured message: header `📝 Update documentation`, a blank second line,
   then a body summarising the key additions to `AGENTS.md`, `DOCS.md`, `README.md`,
   `TODO.md`, and `CHANGELOG.md` (omit any file you skipped).
3. Offer the user the option to undo the last commit.

## 8. Release a new version

1. Verify the working tree is clean with `git status --porcelain`; if any uncommitted change
   exists, notify the user and stop.
2. Ask whether to release a new version. If not, stop here.
3. If so:
   - Move `## [Unreleased]` entries to a new version header with today's date.
   - Update the comparison links in the footer, commit the link changes, and run
     `git tag vX.Y.Z`.
   - Offer the user the option to undo the last commit, or to push the commit and tags.
4. Verify the working tree is clean with `git status --porcelain`.
