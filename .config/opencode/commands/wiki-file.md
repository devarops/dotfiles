---
description: Rename bundle/tmp.md to the correct OKF filename based on parent selection, update log.md, and commit
---

## Overview

Complete the ingestion workflow by renaming `bundle/tmp.md` to a permanent OKF filename, updating the `log.md` creation entry with a link to the new file, and committing.

The command follows a parent-based naming scheme. You select a parent concept from existing `bundle/*.md` files, and the child (`tmp.md`) becomes the next sibling of the parent.

After renaming and logging, the command stages `log.md` and the new bundle file, commits with `✨ Add [title]`, and pushes.

---

## Task

### Step 1 — Read context

Read the following files from `$HOME/repositorios/wiki/`:
- `bundle/tmp.md` — the source document to rename (read its frontmatter to extract `title` and `description` and `resource` if present)
- `log.md` — the log entries (find a line matching `* **Creation**: Added "[title]"`)
- `bundle/*.md` — all existing concept documents (for parent candidate suggestions)

If `bundle/tmp.md` does not exist, notify the user and stop immediately.

### Step 2 — Select a parent concept

Analyse the existing `bundle/*.md` files and select up to 3 candidates that are most similar or closely related to `bundle/tmp.md`.

For each candidate:
- Show the filename, title, and description.
- Explain why it is a good parent candidate for the new concept.

Present the candidates to the user and ask them to choose one.

If the user rejects all candidates, suggest up to 3 new ones. Repeat until a parent is selected.

### Step 3 — Compute the child filename

Given the selected parent filename `P` (without `.md`):

1. Identify the last segment of `P` (everything after the final `.`, or the whole string if no dots):
   - If the last segment contains only digits (e.g. `1`, `3`, `1a.2b.3`) → child = `P` + `a` (e.g. `1a`, `1a.2b.3a`)
   - If the last segment contains digits followed by a letter (e.g. `1a`, `2b`, `1a.2b`) → child = `P` + `.1` (e.g. `1a.1`, `1a.2b.1`)

2. If the computed child filename (with `.md` suffix) already exists in `bundle/`, increment the last segment and try again:
   - Digit-only last segment: increment the letter (`a` → `b` → `c` ...)
   - Digit+letter last segment: increment the digit (`.1` → `.2` → `.3` ...)
   - Stop at the first non-existing filename.

The result is `child.md`.

### Step 4 — Rename `bundle/tmp.md`

Move `$HOME/repositorios/wiki/bundle/tmp.md` to `$HOME/repositorios/wiki/bundle/child.md`.

### Step 5 — Update `log.md`

Read `$HOME/repositorios/wiki/log.md`.

Find the line matching exactly:
```
* **Creation**: Added "[title]" from [source].
```

Where `[title]` is the title read from `tmp.md`'s frontmatter in Step 1.

**If any anomaly occurs** — `log.md` does not exist, no matching creation entry is found, or multiple matches are found — notify the user and abort immediately. Do not proceed with the rename. Do not commit.

Replace the matching line with:
```
* **Creation**: Added ["[title]"](bundle/child.md) from [source].
```

Preserve all other content in `log.md`.

### Step 6 — Commit and push

Stage the two changed files:
```
git add bundle/child.md log.md
```

Read the `[description]` and `[title]` from `tmp.md`'s frontmatter (captured in Step 1). Also capture `[source]` from the log entry (or from `resource` frontmatter field, or from the log line after editing).

Commit with:
```
✨ Add [title]

[description] Ingested from [source].
```

- `[title]` — verbatim from frontmatter (keep ≤72 chars total).
- `[description]` — verbatim from frontmatter.
- `[source]` — the source URL or file path that appears in the log line.

Push:
```
git push
```

### Step 7 — Finish

Summarise what was done:
- Renamed `bundle/tmp.md` → `bundle/child.md`.
- Updated `log.md` creation entry with filename link.
- Committed and pushed.

Remind the user of the remaining next steps (out of scope of this command):
1. Add cross-links to/from other wiki pages.
2. Update `index.md` (if needed — it is auto-generated).
