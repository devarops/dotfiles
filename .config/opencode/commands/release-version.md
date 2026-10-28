---
description: Prepare and publish a semantic-version release.
---

# Release a Version

Prepare and publish one normal release per run.
Read <https://keepachangelog.com/>, <https://semver.org/>, and <https://islas.dev/guia_de_estilo/prosa> in full before writing; if unreadable, report and stop.
Never stage or unstage, amend, or push a branch; commit only the staged release changes after approval.
Edit only `CHANGELOG.md`, `CITATION.cff`, and, when the 1.0.0 checklist applies, `AGENTS.md`; never edit a released version.

## Checklist

A failure stops the run. Report failures, never fix them.

### Before editing

- [ ] **Repository**: tree clean; one GitHub remote, `origin` if present; `develop` attached, in sync; `gh repo view --json nameWithOwner` gives `{owner}/{repo}`.
- [ ] **Tags**: fetch remote tags; changelog versions and local `vX.Y.Z` tags are bijective; each tag's commit contains its header; ignore non-version tags.
- [ ] **Changelog**: Keep a Changelog structure; non-empty Unreleased; footer links, only new and Unreleased possibly missing.
- [ ] **History**: `CHANGELOG.md` describes only `DOCS.md` elements; previous-tag diff shows no unrecorded user-visible change.
- [ ] **Contents**: no credential, key, or token; no restricted-record data; no non-redistributable third-party file; no file over 100 MB outside `tests/data/`; `tests/data/` is anonymized and free of sensitive, personal, or confidential information, though a sample is acceptable — `git ls-tree -r -l HEAD | sort -k4 -n | tail`, review `git ls-files`.
- [ ] **License**: `LICENSE` declares AGPL-3.0 — `gh api repos/{owner}/{repo}/license --jq .license.spdx_id`.
- [ ] **README**: `README.md` says in plain language what the project does and how to run it; a new reader can name both.
- [ ] **Interface**: `AGENTS.md` defines the public interface without listing its elements; a reader cannot enumerate it without `DOCS.md`.
- [ ] **Documentation**: `DOCS.md` lists every public element and nothing else — every `###` heading names a public symbol, route, or CLI the tests exercise.

### Before tagging

- [ ] **Staged release**: exactly `CHANGELOG.md`, `CITATION.cff`, and, when changed, `AGENTS.md` are staged; changelog has calculated header and empty Unreleased; `CITATION.cff` carries same number without `v`; `AGENTS.md` has correct 1.0.0 state; footer links are updated.
- [ ] **Release commit**: tree clean, HEAD contains calculated header, and branch in sync with `origin/develop`; else ask the user to sync, wait, and re-check.
- [ ] **CI**: HEAD has at least one run, all completed, none failed, cancelled, timed out, action required, or stale, and one success — `gh run list --commit <sha> --json status,conclusion`; if incomplete, ask the user to wait and re-check.
- [ ] **Tag absent**: `vX.Y.Z` exists neither locally nor remotely.

### After tagging

- [ ] **Tag**: `vX.Y.Z` points at the `origin/develop` commit; fetch remote-only, push local-only, sync non-version tags; then local and remote version tags agree — `git ls-remote --tags`.
- [ ] **Release**: `gh release view vX.Y.Z` reports tag `vX.Y.Z` and notes matching the section.

## Version

Below 1.0.0, read the `version 1.0.0 release conditions` after the interface definition in `AGENTS.md`.

- Missing or empty: stop.
- Unverifiable: stop, quote it and the gap, ask, re-evaluate; still unverifiable: stop.
- Unmet: use 0.y.z; keep the checklist.
- All met: release 1.0.0; remove it in the same edit.

At 1.0.0 or later, remove it; otherwise leave `AGENTS.md`.

Read the newest version header; if none, release 0.1.0, or 1.0.0 if the 1.0.0 gate is met.

- 0.y.z unmet: feature, deprecation, or incompatible change → MINOR, patch reset; fix → PATCH.
- 1.0.0 or later: follow SemVer.

Normal versions only; a pre-release tag or header stops.

## Edit

Move Unreleased into a new header, fetched format, today's ISO date; leave an empty Unreleased; bump `CITATION.cff` to same number.

Rewrite only the moved entries for clarity and `DOCS.md` alignment: merge redundancies, split independent ideas, preserve facts, add nothing, keep categories unless Keep a Changelog makes one plainly wrong; report every move.
Re-check entries and structure; stop on failure.

Footer links: keep pattern or derive the base URL from the remote, stopping if impossible; first version links to its tag, later from previous tag, Unreleased to HEAD.

## Commit

Show the diff; ask the user to stage `CHANGELOG.md`, `CITATION.cff`, and, when changed, `AGENTS.md`.
Wait.
Stop on anything else staged, a missing file, or an unstaged release file.
Never stage or unstage.
Complete the **Staged release** checklist item.

Read every commit message and patch since the last tag, plus the staged diff; a first release starts at the root.
Changelog for what, commits for why and how.
Build a private OCAR brief—characters, opening, challenge, action, resolution, exclusions—and select the arc, not the log.

Subject: `🏷️ Release version X.Y.Z: <blog title>`, under 72 characters, blank second line; the title reads as a blog title.
Body: OCAR, at most 500 words, never padded; sentences at most 25 words; plain prose, no Markdown, backticks, quotes, or labels; team voice, never I, the user, the author, the assistant, or the agent; files, commands, and versions may be subjects; English per the prose guide; version X.Y.Z or vX.Y.Z at most once, at the resolution, never bare.
Exclude implementation detail, unrelated work, and status bookkeeping.
Do not list commits, restate the changelog, repeat the title or facts, or invent changes; trace every claim to a commit or the changelog.

Present only the message and wait; revise and re-present.
If a release file changes, ask the user to re-stage, re-verify, and redraft.
On approval, commit; never stage, unstage, amend, or push a branch.

## Publish

Fetch the remote; stop on failure.
Complete **Release commit**, **CI**, and **Tag absent**; stop on failure.
Write the new section to `/tmp/opencode/release-notes-X.Y.Z.md`.
If HEAD differs from the staged state, stop; do not amend.

Create and push the lightweight tag `vX.Y.Z`; on a failed read, fetch, or push, report, keep state, stop; never force, move, or delete a tag.
Complete the **Tag** checklist item.

Run `gh release create vX.Y.Z --verify-tag --notes-file /tmp/opencode/release-notes-X.Y.Z.md`; on failure, report the tag and that command, keep state, stop.
Complete the **Release** checklist item.

Report commit hash, subject, tag, push, release URL, and sync results; state it staged nothing, amended nothing, pushed no branch.
