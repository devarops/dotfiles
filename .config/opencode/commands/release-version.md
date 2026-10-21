---
description: Cut a semantic-version release from CHANGELOG.md and publish its tag.
---

# Release a Version

Cut one normal release per run. Read <https://keepachangelog.com/>, <https://semver.org/>, and <https://islas.dev/guia_de_estilo/prosa> in full before writing; if any cannot be read, report and stop. The first two govern the changelog and increments; the Spanish prose guide governs the English message. Never stage or unstage, amend, or push a branch; commit only the staged release changes after message approval. Edit only `CHANGELOG.md` and, when the version 1.0.0 checklist applies, `AGENTS.md`; never edit a released version.

## Gate

- The tree must be clean. Run `git status --porcelain`; if it prints anything, report and stop.
- `CHANGELOG.md`, `AGENTS.md`, and `DOCS.md` must exist; otherwise report and stop.
- Discover the remote: `origin` if present, otherwise the only remote. Zero or several remotes: report and stop.
- Stop on a detached HEAD.

## Verify

Fetch remote tags; report and stop on failure. Then verify:

- Unreleased has at least one entry.
- Every changelog version has a local `vX.Y.Z` tag, every version tag has a changelog version, and the tag's commit contains that header; ignore non-version tags.
- `AGENTS.md` defines the public interface without listing its elements; `DOCS.md` lists exactly those elements. Every changelog entry refers to a `DOCS.md` element and nothing else.
- `CHANGELOG.md` follows the fetched Keep a Changelog structure: heading, Unreleased at the top, ISO-dated version headers, newest first, the prescribed categories, non-empty entries, and footer links. Missing links for the new version and Unreleased are created later; any other footer failure stops.

Report every provable failure and stop; send interface or changelog failures to `/end` and tag mismatches for manual repair.

## Version 1.0.0 gate

Below version 1.0.0, find the `version 1.0.0 release conditions` checklist immediately after the interface definition in `AGENTS.md`.

- Missing or empty: report and stop.
- Unverifiable condition: stop, quote it and the evidence gap, ask, and re-evaluate; still unverifiable: stop.
- Unmet condition: follow the version 0.y.z algorithm; keep the checklist.
- All met: next version is version 1.0.0; remove the checklist in the same edit.

At version 1.0.0 or later, remove it; otherwise leave `AGENTS.md` alone.

## Version

Read the newest version header. Without one, the first release is version 0.1.0, or version 1.0.0 when the gate is met.

- While version 0.y.z, if the gate is unmet: a feature, deprecation, or incompatible change bumps MINOR and resets patch; a fix bumps PATCH.
- At version 1.0.0 or later: follow the fetched SemVer rules.

Normal versions only; a pre-release tag or header stops.
Stop if the new `vX.Y.Z` tag exists locally or remotely; report both.

## Edit

Move Unreleased into a new version header, using the fetched format and today's ISO date; leave a fresh empty Unreleased.

Rewrite only the moved entries: improve clarity, merge redundancies, split independent ideas, and align them with `DOCS.md`. Preserve facts, add nothing, keep the prescribed categories, and recategorise only when the fetched guide makes the category plainly wrong; report every move. Re-check the entries and structure; stop on failure.

Update the footer comparison links. Keep an existing pattern; otherwise derive the base URL from the remote, stopping if impossible. The first version links to its tag; later versions compare from the previous tag; Unreleased compares the new tag to HEAD.

## Commit

Show the diff; ask the user to stage `CHANGELOG.md` and, when changed, `AGENTS.md`. Wait. Require exactly those staged files; stop and ask the user to fix anything else, a missing file, or an unstaged release file. Verify the staged changelog has the calculated version header and an empty Unreleased, and AGENTS.md has the correct checklist state; stop otherwise. Never stage or unstage.

Read every commit message and patch from the last version tag to HEAD, plus the staged diff; for a first release, start at the root. Use the changelog for what and the commits for why and how. Build a private OCAR brief—characters, opening, challenge, action, resolution, exclusions—and do not show it. Select the arc, not the log.

Draft the message. Subject: `🏷️ Release version X.Y.Z: <blog title>`, under 72 characters, blank second line; the title reads as a blog title. Body: OCAR, at most 800 words, no minimum, never padded; each sentence at most 25 words; plain prose paragraphs, no Markdown, backticks, quotes, or labels; team voice, never I, the user, the author, the assistant, or the agent; files, commands, and versions may be subjects; English following the prose guide; the body may name version X.Y.Z or vX.Y.Z at most once at the resolution, never bare. Exclude implementation detail, unrelated work, and status bookkeeping. Do not list commits, restate the changelog, repeat the title or facts, or invent changes; trace every claim to a commit or the changelog. Tell the story as a blog post.

Present only the message and wait; apply edits and re-present. If a release file changes, ask the user to re-stage it, re-verify, and redraft. On approval, commit the staged changes with the approved message; never stage, unstage, amend, or push a branch.

## After the commit

Fetch the remote; report and stop on failure. Verify:

- The tree is clean.
- HEAD contains the calculated normal version header.
- The version 1.0.0 checklist is absent from version 1.0.0 onward, and present below it.
- The branch is in sync with its upstream. If not, ask the user to sync, wait, and re-check.

If HEAD differs from the staged state, report and stop; do not amend.

Re-check that `vX.Y.Z` is absent locally and remotely; report both if it exists.

Create and push the lightweight tag `vX.Y.Z`. On any failed remote read, fetch, or push, report, keep state, and stop; never force, move, or delete a tag.

List remote tags and compare names and resolved commits. If a name resolves differently, report and stop. Fetch remote-only tags, push local-only tags, and sync non-version tags too.

Report the commit hash, subject, tag, push, and sync results; state it staged nothing, amended nothing, pushed no branch.
