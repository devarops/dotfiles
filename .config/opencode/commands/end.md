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
| `DOCS.md` | Technical reference for APIs, CLI commands, and data models. | Developers |
| `README.md` | High-level project overview and usage instructions. | End Users |
| `CHANGELOG.md` | Record of interface changes (visible from the tests) following SemVer and Keep a Changelog. | Developers |
| `TODO.md` | Active backlog and session-to-session focus ("The Gold"). | Developers |

---

## 1. Update AGENTS.md

Update or create `AGENTS.md` for this repository.

The goal is a compact instruction file that helps future OpenCode sessions avoid mistakes and ramp up quickly.

Identify any patterns, infrastructure changes, or workflow conventions that emerged during this session.

Every line should answer:
"What did you learn in this session that is not currently documented in `AGENTS.md`?"
"Would an AI agent likely miss this without help?" If not, leave it out.

Read the highest-value sources first:
- Tests in tests/*
- Other tests, lint, formatter, typecheck, and codegen config
- CI workflows and pre-commit / task runner config

Prefer the tests over anything else.
If architecture is still unclear after reading tests, config, and docs, inspect a small number of representative code files to find the real entrypoints, package boundaries, and execution flow.

Prefer executable sources of truth over prose.
If docs conflict with config or scripts, trust the executable source and only keep what you can verify.

Look for the highest-signal facts for an agent working in this repo:
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
- exact commands and shortcuts the agent would otherwise guess wrong
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
If the repo is large, summarize the few structural facts that actually change how an agent should work.

If `AGENTS.md` already exists, improve it in place rather than rewriting blindly.
Map findings to the appropriate sections in `AGENTS.md`.
Keep additions concise and consistent with the existing tone.
Preserve verified useful guidance, delete fluff or stale claims, and reconcile it with the current codebase.

If `AGENTS.md` is 200 lines or longer, truncate it to 100 lines by removing the lowest-signal content.

Present the changes and explain. **Do not commit yet.**

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

## 3. Update README.md (End-User Focused)
Rewrite or update `README.md` for a non-technical audience.
- **Constraints:** Zero overlap with AGENTS.md or DOCS.md.
  No jargon, no implementation details, no algorithm explanations.
- **Structure:**
  1. **Tagline:** Memorable phrase below the title. Explains what it is.
  2. **What it does:** The problem this project solves.
  3. **How to use it:** User journey through the public interface.
  4. **Before you start:** Required configuration or credentials.
  5. **Run the project:** Setup instructions (Docker preferred, then native).
  6. **Coming soon:** Bulleted list of planned features.
- **Review:** Present the changes and explain. **Do not commit yet.**

## 4. Update CHANGELOG.md (SemVer)
Update `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/).

- **Version bump:** ([Semantic Versioning (SemVer)](https://semver.org/))

  - **MAJOR:** Incompatible changes. Tests from the previous version fail under the new implementation.
  - **MINOR:** Backward-compatible features added. Tests from the previous version continue to pass under the new implementation.
  - **PATCH:** Backward-compatible bug fixes.
  - **Note:** For `0.y.z` versions, increment the MINOR version for every release.

- **Process:**

  1. **Audit tags:** Verify that every changelog version has a corresponding Git tag (`vX.Y.Z`) and that every Git tag appears in the changelog. Resolve any mismatches.
  2. **Discover changes:** Run `git diff <last_tag>..HEAD -- <test_directory>/` (for example, `tests/`) to inspect modified tests. Infer only user-visible behavior, features, functions, or data-model changes from the tests, but do not mention tests in the changelog.
  3. Consider only user-facing changes at the topmost layer.
  4. Categorize changes under: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, and `Security`.
  5. Add all new changes since last vX.Y.Z tag to the `## [Unreleased]` section.
  6. **Constraint:** Describe features and behavior, not tests. Use one bullet point per entry. Wrap code symbols in backticks.

- **Review:** Present the proposed changes and explain them. Do not commit yet.


## 5. Clean TODO.md
- Remove all completed items (`[x]`).
- Remove items that are now implicitly completed or obsolete.
- **The Gold:** Ensure within the first few lines there is a clear "Gold" objective. If the current Gold was removed, set a new one based on the next priority item.
- **Inventory:** If an Inventory table exists, keep only "To Do" rows.
- **Review:** Present the changes and explain. **Do not commit yet.**

## 6. Commit and Tag
Once all changes are reviewed:
1. **Stage all updated files.**
2. **Commit with a structured message:**
   - **Header:** `📝 Update documentation and session housekeeping`
   - **Body:** Summarize key additions to `AGENTS.md`, `DOCS.md`, `README.md`, `TODO.md`, and the `CHANGELOG.md` release.
4. **Release a new version:** Offer the user to move `## [Unreleased]` entries to a new version header with today's date.
3. **Tag the release:** If a new version was added to the changelog, update comparison links in the footer, commit and run `git tag vX.Y.Z`.
5. **Undo or Push:** Offer the user the option to undo the last commit or push the commit and tags to the remote.
