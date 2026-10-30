---
description: $1: target version. Prepare and publish a semantic-version release.
---

# Release a Version

Read <https://keepachangelog.com/>, <https://semver.org/>, and <https://islas.dev/guia_de_estilo/prosa>; if unreadable, report and stop.
Never stage, unstage, amend, or push a branch; commit only the staged release changes after approval.
Edit only `CHANGELOG.md`, `CITATION.cff`, and, when the 1.0.0 checklist applies, `AGENTS.md`; never edit a released version.
A failure stops the run: report it, never fix it.

## Repository

Tree clean; one remote, `origin` if present; `develop` attached, in sync; `gh repo view --json nameWithOwner` gives `{owner}/{repo}`.

## Target version

Confirm one target before the checklist.

- With `$1`, the requested version is the target.
- Without `$1`, take the highest `vX.Y.Z` tag; without tags, `0.1.0`, or `1.0.0` if the conditions below are met.
- Otherwise it is an immediate successor of that release: `X.Y.Z+1`, `X.Y+1.0`, or `X+1.0.0`. A fix takes the patch; a feature or incompatible change takes the minor. At 1.0.0 or later, follow SemVer. Refuse every other version.

Below 1.0.0, read the `version 1.0.0 release conditions` after the interface definition in `AGENTS.md`.

- Missing or empty: stop.
- Unverifiable: stop, quote the gap, ask once.
- Unmet: stay below 1.0.0, so a calculated 1.0.0 becomes its minor successor.
- All met: `1.0.0`; remove the conditions in the same edit.

At 1.0.0 or later, remove the conditions. Show the requested version beside the calculated one, then confirm; a decline stops. When `$1` is `1.0.0` and the conditions are unmet, name them and require a second yes.

A target whose header already exists is an error: report and stop. Only what sits under `Unreleased` is released, with no exception, even after a release commit whose tag push failed.

Normal versions only; a pre-release tag or header stops.

## Checklist

### Before editing

- [ ] **Tags**: fetch remote tags; every changelog version except the target has a local `vX.Y.Z` tag whose commit contains its header; ignore non-version tags.
- [ ] **Changelog**: Keep a Changelog structure; non-empty Unreleased; footer links, only new and Unreleased missing.
- [ ] **History**: entries describe only `DOCS.md` elements; the previous-tag diff shows no unrecorded change.
- [ ] **Contents**: no credential, key, or token; no restricted data; no non-redistributable file; no file over 100 MB outside `tests/data/`, which carries no personal data — `git ls-tree -r -l HEAD | sort -k4 -n | tail`, then `git ls-files`.
- [ ] **License**: `LICENSE` declares AGPL-3.0 — `gh api repos/{owner}/{repo}/license --jq .license.spdx_id`.
- [ ] **README**: says plainly what the project does and how to run it.
- [ ] **Interface**: `AGENTS.md` defines the public interface without listing its elements.
- [ ] **Documentation**: `DOCS.md` lists every public element and nothing else; each `###` heading names a public symbol, route, or CLI.

### Before tagging

- [ ] **Staged release**: exactly `CHANGELOG.md`, `CITATION.cff`, and, when changed, `AGENTS.md` are staged; the header is confirmed, Unreleased is empty, `CITATION.cff` carries the number without `v`, and footer links are updated.
- [ ] **Release commit**: tree clean, HEAD contains the header, branch in sync with `origin/develop`; else ask the user to sync, wait, re-check.
- [ ] **CI**: when the repository defines workflows, HEAD has one completed run, none failed, cancelled, timed out, action required, or stale, and one success — `gh workflow list`, then `gh run list --commit <sha> --json status,conclusion`. Without workflows it passes; a workflow with no run at HEAD does not, so wait and re-check.
- [ ] **Tag absent**: `vX.Y.Z` exists neither locally nor remotely.

### After tagging

- [ ] **Tag**: `vX.Y.Z` points at the `origin/develop` commit; fetch remote-only, push local-only, sync non-version tags; local and remote agree — `git ls-remote --tags`.
- [ ] **Release**: `gh release view vX.Y.Z` reports the tag and notes matching the section.

## Edit

Move Unreleased into a new header with today's ISO date; leave Unreleased empty; bump `CITATION.cff` to the same number.

Rewrite only the moved entries for clarity and `DOCS.md` alignment: merge redundancies, split ideas, preserve facts, add nothing, keep categories unless Keep a Changelog makes one wrong; report every move. Re-check; stop on failure.

Footer links: keep the pattern, or derive the base URL from the remote; the first version links to its tag, later ones from the previous, Unreleased to HEAD.

## Commit

Show the diff; ask the user to stage `CHANGELOG.md`, `CITATION.cff`, and, when changed, `AGENTS.md`. Wait. Stop on anything else staged, a missing file, or an unstaged release file. Never stage or unstage.
Read every commit and patch since the last tag, plus the staged diff; a first release starts at the root. Changelog for what, commits for why and how. Build a private OCAR brief and select the arc, not the log.

Subject: `🏷️ Release version X.Y.Z: <blog title>`, under 72 characters, blank second line; the title reads as a blog title.

Body: OCAR, at most 500 words; sentences at most 25; plain prose, no Markdown, backticks, quotes, or labels; team voice, never I, the user, the author, the assistant, or the agent; version X.Y.Z or vX.Y.Z at most once, at the resolution, never bare. Exclude implementation detail, unrelated work, and status bookkeeping. Do not list commits, restate the changelog, repeat the title, or invent changes; trace every claim to a commit or the changelog.

Present only the message and wait; revise and re-present. If a release file changes, ask the user to re-stage, re-verify, and redraft. On approval, commit; never stage, unstage, amend, or push a branch.

## Publish

Fetch the remote. Complete **Release commit**, **CI**, and **Tag absent**; stop on failure. Write the section to `/tmp/opencode/release-notes-X.Y.Z.md`. If HEAD differs from the staged state, stop.

Create and push the lightweight tag `vX.Y.Z`; on failure report, keep state, and stop; never force, move, or delete a tag.

Run `gh release create vX.Y.Z --verify-tag --notes-file /tmp/opencode/release-notes-X.Y.Z.md`; on failure, report the tag and command, keep state, stop.

Report commit hash, subject, tag, push, release URL, and sync results; state it staged nothing, amended nothing, pushed no branch.
