---
description: Ingest a source into the LLM Wiki via structured interview and write to bundle/tmp.md
---

## Overview

Ingest a source document (URL or local file) into the LLM Wiki at `$HOME/repositorios/wiki/`.

The process follows a structured interview: 4 constant questions first (type, title, description, tags), then up to 10 free-form questions generated from the source content.
After the interview, a valid OKF concept document is written to `bundle/tmp.md` and an entry is appended to `log.md`.
The user renames `tmp.md` and commits separately.

The first argument (`$1`) is the source — either a URL (`https?://...`) or a local file path.

---

## Task

### Step 1 — Verify clean working tree

Run `git status --porcelain` inside `$HOME/repositorios/wiki/`.
- If any uncommitted change exists, notify the user and stop immediately.
- If clean, proceed.

### Step 2 — Read context

Read the following to understand the wiki's current state and structural rules:

- `https://raw.githubusercontent.com/GoogleCloudPlatform/knowledge-catalog/refs/heads/main/okf/SPEC.md` — the OKF specification
- `$HOME/repositorios/wiki/AGENTS.md` — OKF conventions and workflow guidance
- `$HOME/repositorios/wiki/bundle/*.md` — existing concept documents
- `$HOME/repositorios/wiki/log.md` — existing log entries

### Step 3 — Fetch or read the source

- If `$1` matches `https?://*`, fetch the URL content with `webfetch`.
- Otherwise, read the local file at `$1`.

Present a brief summary of the source to the user before starting the interview.

### Step 4 — 4 constant questions

Ask these four questions **in order, one at a time**.
Do not proceed to the next until the user has answered.

For each question:
- Offer concrete answer options derived from the source content and wiki context.
- Indicate your recommended option and justify why it fits.
- Wait for the user's input.
- If the user rejects your recommendation, let them explain why and try again.

**Question 1 — Type:**
```
What type of concept best describes this source?
```
Consider existing types used in `bundle/*.md` (e.g., Summary, Concept).
Propose options the source could plausibly fit.

**Question 2 — Title (≤10 words):**
```
What is a concise title for this concept?
```
Propose short, descriptive titles.
Respect the 10-word limit.

**Question 3 — Description (≤20 words):**
```
What is a one-line description of this concept?
```
Propose descriptions that capture the essence.
Respect the 20-word limit.

**Question 4 — Tags:**
```
What tags or categories should this concept carry?
```
Propose 2–4 tags as a YAML list.
Consider cross-cutting categories that help with discovery.

### Step 5 — Up to 10 free-form questions

Generate questions dynamically based on the source content.
The goal is to surface nuances, context, connections, and anything the LLM cannot infer on its own.

Rules:
- Ask exactly one question at a time.
- For each question, offer concrete answer options, recommend one, and justify.
- Wait for user input before the next question.
- Allow the user to stop early (the 4 constants are already answered).
- Do not exceed 10 free-form questions.

Topics the LLM might probe:
- Key claims or arguments in the source
- Relationships to other concepts (noted for later cross-linking, not written now)
- Context the user wants to add that the source doesn't capture
- Areas of disagreement, uncertainty, or nuance
- Practical implications or applications

### Step 6 — Write bundle/tmp.md

Generate a valid OKF concept document at `$HOME/repositorios/wiki/bundle/tmp.md`.

**Frontmatter** (YAML, delimited by `---`):
- `type` — from Question 1 (non-empty string)
- `title` — from Question 2 (≤10 words)
- `description` — from Question 3 (≤20 words)
- `tags` — from Question 4 (YAML list)
- `resource` — the source URL (only if `$1` is a URL)

**Body:**
- Conform to the OKF spec and `AGENTS.md` rules:
  - One sentence per line
  - Each sentence ≤25 words
  - Total body ≤200 words (excluding frontmatter)
- Synthesize content from both the source document and the interview answers.
- Do not add cross-links to other wiki pages (they will be added in a separate step).
- Write to `bundle/tmp.md` (not a permanent filename).

Present the generated content to the user for approval.
Show it clearly.
Ask:
- Does the content accurately reflect the source and our discussion?
- Any edits or refinements?

If the user requests changes, apply them and show the updated version.
Repeat until the user approves.

### Step 7 — Append to log.md

After the user approves the content, append one entry to `$HOME/repositorios/wiki/log.md`:

```markdown
## YYYY-MM-DD
- **Creation**: Added "[title]" from [source].
```
- `YYYY-MM-DD` — today's date in ISO 8601 format.
- `[title]` — the approved title from Question 2.
- `[source]` — the URL or file path provided as `$1`.
- Do not reference the filename `tmp.md` — the user will rename it immediately.
- Append to the end of `log.md` (or insert under today's heading if one already exists).

### Step 8 — Finish

Summarise what was done:
- Source ingested.
- Interview completed (N questions answered).
- `bundle/tmp.md` written and approved.
- `log.md` updated.

Remind the user of the next steps (out of scope of this command):
1. Rename `bundle/tmp.md` to the correct OKF filename.
2. Add cross-links to/from other wiki pages.
3. Update `index.md` (if needed — it is auto-generated).
4. Commit the changes.

Do not commit.
Do not stage.
Do not modify `index.md`.
