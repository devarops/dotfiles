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

## Phase 1: Internal Knowledge (`AGENTS.md` & `DOCS.md`)

### 1. Update AGENTS.md
Identify any patterns, infrastructure changes, or workflow conventions that emerged during this session.
What did you learn in this session that is not currently documented in `@AGENTS.md`?
- Map findings to the appropriate sections in `AGENTS.md`.
- Keep additions concise and consistent with the existing tone.
- **Review:** Present the changes and explain. **Do not commit yet.**

### 2. Update DOCS.md
Update the technical reference with any new or modified interfaces.
Infer interfaces only from the test, but don't mention tests in DOCS.md.
- **Format:** Every entry must follow this structure:
  ### `symbol_name(signature)` or ### GET/POST /endpoint/ or ### cli command --options
  One-line description.
  - **Parameters**: name, type, description
  - **Returns**: type and description
  - **Errors**: exception types and triggers (omit if none)
  - **Notes**: edge cases or limitations (omit if none)
- **Constraint:** Remove all test-specific language (e.g., "verified by tests"). Correct any inaccuracies in naming or signatures.
- **Review:** Present the changes and explain. **Do not commit yet.**

---

## Phase 2: Product Documentation (`README.md` & `CHANGELOG.md`)

### 3. Update README.md (End-User Focused)
Rewrite or update `README.md` for a non-technical audience.
- **Constraints:** Zero overlap with internal docs. No jargon, no implementation details, no algorithm explanations.
- **Structure:**
  1. **Tagline:** Memorable phrase below the title.
  2. **How it works:** User journey through the public interface. Use a table for feature status (Ready/Coming soon).
  3. **Before you start:** Required configuration or credentials.
  4. **Run the project:** Setup instructions (Docker preferred, then native).
  5. **Core concept:** Simple "If you do X → Y happens" explanations.
  6. **Coming soon:** Bullet list of planned features.
- **Review:** Present the changes and explain. **Do not commit yet.**

### 4. Update CHANGELOG.md (SemVer)
Update `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/).
- **Version Bump:** ([SemVer](https://semver.org/))
  - **MAJOR:** Incompatible changes (tests of previous version fail under new implementation).
  - **MINOR:** Compatible new features added (tests of previous version pass under new implementation).
  - **PATCH:** Compatible bug fixes.
  - *Note: In `0.y.z`, increment MINOR for every release.*
- **Process:**
  1. **Audit Tags:** Check that every version in the changelog has a corresponding git tag (`vX.Y.Z`) and vice versa. Fix mismatches.
  2. **Discover Changes:** Run `git diff <last_tag>...HEAD -- <test_directory>/` (e.g., `tests/`) to see modified tests. Infer user-observable features, functions, or data-model changes only from the test, but don't mention tests in the changelog.
  3. Map changes to categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`.
  3. **Constraint:** Describe features, not tests. One entry per bullet point. Use backticks for code symbols.
  4. Move `Unreleased` entries to a new version header with today's date.
  5. Update comparison links in the footer.
- **Review:** Present the changes and explain. **Do not commit yet.**

---

## Phase 3: Housekeeping (`TODO.md`)

### 5. Clean TODO.md
- Remove all completed items (`[x]`).
- Remove items that are now implicitly completed or obsolete.
- **The Gold:** Ensure within the first few lines there is a clear "The Gold" objective. If the current Gold was removed, set a new one based on the next priority item.
- **Inventory:** If an Inventory table exists, keep only "To Do" rows.
- **Review:** Present the changes and explain. **Do not commit yet.**

---

## Phase 4: Finalization

### 6. Commit and Tag
Once all changes are reviewed:
1. **Stage all updated files.**
2. **Commit with a structured message:**
   - **Header:** `📝 Update documentation and session housekeeping`
   - **Body:** Summarize key additions to `AGENTS.md`, `DOCS.md`, `README.md`, `TODO.md`, and the `CHANGELOG.md` release.
3. **Tag the release:** If a new version was added to the changelog, run `git tag vX.Y.Z`.
4. **Push:** Push the commit and tags to the remote.
