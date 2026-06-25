---
name: end
description: Capture session learnings, update documentation, and perform housekeeping before closing.
---

Before starting, use `git status --porcelain` to verify that the working tree is clean.
If any uncommitted change exists, notify the user and stop immediately.

## File Registry

| File | Purpose | Audience |
| :--- | :--- | :--- |
| `AGENTS.md` | Internal guidelines, patterns, and infrastructure conventions. | Developers |
| `CHANGELOG.md` | Record of public interface changes (visible to the end user) following SemVer and Keep a Changelog. | End Users |
| `DOCS.md` | Technical reference for APIs, CLI commands, and data models. | Developers |
| `README.md` | High-level project overview and usage instructions. | End Users |
| `TODO.md` | Current backlog. | Developers |

---

## 1. Update AGENTS.md

Update or create `AGENTS.md` for this repository.

The goal is a compact instruction file that helps future AI agents avoid mistakes and ramp up quickly.

Identify any patterns, infrastructure changes, or workflow conventions that emerged during this session.

Every line should answer:
"What did you learn in this session that is not currently documented in `AGENTS.md`?"
"Would an AI agent likely miss this without help?" If not, leave it out.

Read the highest-value sources first:
- Tests in tests/*
- Other tests, lint, formatter, typecheck, and codegen config
- CI workflows and pre-commit / task runner config

Prefer the tests over anything else.
Read Makefile and every file on the root directory.
If architecture is still unclear after reading the tests and root files, then inspect the entire codebase to find the real entrypoints, package boundaries, and execution flow.

Prefer executable sources of truth over prose.
If docs conflict with config or scripts, trust the executable source and only keep what you can verify.

Look for the highest-signal facts for an AI agent working in this repo:
- exact developer commands, especially non-obvious ones
- how to run a single test, a single package, or a focused verification step
- required command order when it matters, such as `lint -> typecheck -> test`
- monorepo or multi-package boundaries, ownership of major directories, and the real app/library entrypoints
- framework or toolchain quirks: generated code, migrations, codegen, build artifacts, special env loading, dev servers, infra deploy flow
- repo-specific style or workflow conventions that differ from defaults
- testing quirks: fixtures, integration test prerequisites, snapshot workflows, required services, flaky or expensive suites
- important constraints from existing instruction files worth preserving

Good `AGENTS.md` content is usually hard-earned context that took reading multiple files to infer.

Include only high-signal, repo-specific guidance such as:
- exact commands and shortcuts the AI agent would otherwise guess wrong
- architecture notes that are not obvious from filenames
- conventions that differ from language or framework defaults
- setup requirements, environment quirks, and operational gotchas
- references to existing instruction sources that matter

Exclude:
- generic software advice
- long tutorials or exhaustive file trees
- obvious language conventions
- speculative claims or anything you could not verify
- content better stored in a separate file and referenced here

When in doubt, omit.

Prefer short sections and bullets.
If the repo is simple, keep the file simple.
If the repo is large, summarize the few structural facts that actually change how an AI agent should work.

If `AGENTS.md` already exists, improve it in place rather than rewriting blindly.
Map findings to the appropriate sections in `AGENTS.md`.
Keep additions concise and consistent with the existing tone.
Preserve verified useful guidance, delete fluff or stale claims, and reconcile it with the current codebase.

If `AGENTS.md` is 200 lines or longer, truncate it to 100 lines by removing the lowest-signal content.

Exclude from the line count anything below a `---` boundary that the user created to separate the content they maintain from the content the AI agent maintains.
This allows users to keep an extended set of notes, instructions, or conventions below the boundary without worrying about them being edited or deleted by the agent during future updates to `AGENTS.md`.
If such a boundary exists, do not edit or remove it, and do not count any lines below it toward the 200-line limit.
Don't remove, edit, add or touch any content below the boundary `---`.
Do not add a boundary if one does not already exist.

Review: Present the changes and explain. Do not commit yet.

## 2. Update DOCS.md

Update the interface technical reference documentation for any new or modified public interface.
Infer interfaces exclusively from the tests.
However, do not mention tests, testing strategy, or implementation details in DOCS.md.

Format: Every entry must follow this structure:

  ### symbol_name(signature)
  or
  ### GET/POST /endpoint/
  or
  ### cli command --options

  One-line description.

  - Parameters: name, type, description
  - Returns: type and description
  - Errors: exception/error types and triggering conditions (omit if none)
  - Notes: edge cases, constraints, side effects, or limitations (omit if none)

Review: Present the changes and explain. Do not commit yet.

## 3. Update CHANGELOG.md (SemVer; End-User Focused)

Update `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/).

- Version bump: (Semantic Versioning: SemVer)
  - MAJOR: Incompatible changes. Tests from the previous version fail under the new implementation.
  - MINOR: Backward-compatible features added. Tests from the previous version continue to pass under the new implementation.
  - PATCH: Backward-compatible bug fixes.
  - Note: For 0.y.z versions, increment the MINOR (y) version for every release.

- Process:
  1. Audit tags: Verify that every changelog version has a corresponding Git tag (`vX.Y.Z`) and that every Git tag appears in the changelog. Resolve any mismatches.
  2. Discover changes: Run `git diff <last_tag>..HEAD -- tests/` to inspect modified tests. Infer only user-visible behavior, features, functions, or data-model changes from the tests, but do not mention tests in the changelog.
  3. If the project has multiple layers, consider only user-facing changes at the topmost layer.
  4. Ignore changes that the user cannot access from the topmost layer (CLI, API, etc.).
  5. Categorize changes under: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.
  6. Add all new changes since the last vX.Y.Z tag to the `## [Unreleased]` section.
  7. Describe features and behavior from the perspective of the end user.
  8. Avoid mentioning implementation details, internal changes, or tests.
  9. Focus on what the user can observe and experience.
 10. Use one bullet point per entry. Wrap code symbols in backticks.

Review: Present the changes and explain. Do not commit yet.

## 4. Update README.md (End-User Focused)

Rewrite or update `README.md` for a non-technical audience.
Ensure the final README.md does not contain any information that overlaps with `AGENTS.md`, `DOCS.md`, or `CHANGELOG.md`.

- Constraints:
  - Remove from README.md any overlap with AGENTS.md.
  - Remove from README.md any overlap with DOCS.md.
  - Remove from README.md any overlap with CHANGELOG.md.
  - No jargon, no implementation details, no algorithm explanations.

- Structure:
  1. Tagline: Memorable phrase below the title. Explains what it is.
  2. What it does: The problem this project solves.
  3. How to use it: User journey through the public interface.
  4. Before you start: Required installation, configuration or credentials.
  5. Run the project: Setup instructions (Docker preferred, then native).

Review: Present the changes and explain. Do not commit yet.

## 5. Clean TODO.md

- Remove all completed items (`[x]`).
- Remove items that tests confirm are now completed or obsolete, even if the user didn't mark them as done.

Review: Present the changes and explain. Do not commit yet.

## 6. Commit and Tag

Ask the user to review and approve the changes. Stop and wait for approval.
Once all changes are reviewed and approved:

1. Stage all updated files.
2. Commit with a structured message:
   - Header: `📝 Update documentation`
   - Blank second line.
   - Body: Summarize key additions to `AGENTS.md`, `DOCS.md`, `README.md`, `TODO.md`, and `CHANGELOG.md`.
3. Offer the user the option to undo the last commit.

## 7. Release a new version

1. Use `git status --porcelain` to verify that the working tree is clean.
   If any uncommitted change exists, notify the user and stop immediately.
2. Ask the user whether to release a new version.
3. If the user chooses not to release a new version, stop here and end the command.
4. If the user chooses to release a new version, continue.
    - Move `## [Unreleased]` entries to a new version header with today's date.
    - Update comparison links in the footer, commit the link changes, and run `git tag vX.Y.Z`.
    - Undo or Push: Offer the user the option to undo the last commit or push the commit and tags to the remote.
5. Use `git status --porcelain` to verify that the working tree is clean.
