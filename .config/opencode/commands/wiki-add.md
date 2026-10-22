---
description: Ingest a source or idea into the LLM Wiki via structured interview and write to bundle/tmp.md
---

## Overview

Ingest a source or capture an idea into the LLM Wiki at `$HOME/repositorios/wiki/`.

The process follows a structured interview: 10 to 20 free-form questions exploring the source or the idea, then 4 constant questions (type, title, description, tags).
After the interview, redundancy with existing concepts is checked and resolved.
A valid OKF concept document is written to `bundle/tmp.md` and an entry is appended to `log.md`.
The user renames `tmp.md` and commits separately.

The first argument (`$1`) is optional: a URL (`https?://...`), a local file path, or the idea itself.

---

## Task

### Step 1 — Verify clean working tree

Run `git status --porcelain` inside `$HOME/repositorios/wiki/`.
- If any uncommitted change exists, notify the user and stop immediately.
- If clean, check `bundle/tmp.md`; if it exists, report the pending draft and stop.

### Step 2 — Read context

Read the following to understand the wiki's current state and structural rules:

- `https://raw.githubusercontent.com/GoogleCloudPlatform/knowledge-catalog/refs/heads/main/okf/SPEC.md` — the OKF specification
- `$HOME/repositorios/wiki/AGENTS.md` — OKF conventions and workflow guidance
- `$HOME/repositorios/wiki/log.md` — existing log entries
- `$HOME/repositorios/wiki/bundle/*.md` — existing concept documents

### Step 3 — Fetch, read, or capture the source

`$1` is optional, and takes three forms:
- A URL (`https?://*`): fetch it with `webfetch`.
- A path to an existing, readable file: read it.
- Absent, or free text that is neither: treat the text as the idea itself.

If a URL or path cannot be fetched or read, report the failure, then offer to find a source or to continue without one.

When there is no source, ask whether the user wants help finding a source:
- If yes, search the web (`websearch`) and `raw/`, and propose one to three real candidates — each a title, URL, and one-line reason it fits.
- Never invent a title or URL. If nothing credible is found, continue without a source.
- The user picks a candidate or declines.

After resolving `$1`, trim it and compare it with every `resource` field in `bundle/*.md` and every source in `log.md`. If the same source already appears, report the existing title and file and stop; do not interview or write. Skip this check when `$1` is absent or free text.

Present a brief summary of the source — or, without one, of the idea — before starting the interview.

### Step 4 — 10 to 20 free-form questions

Generate questions dynamically based on the source content.
The goal is to surface nuances, context, connections with other `bundle/*.md` concept documents, and anything the LLM cannot infer on its own.

Rules:
- Ask exactly one question at a time.
- For each question, offer concrete answer options and justify each.
- Wait for user input before the next question.
- Focus on information that is not already covered in the existing concepts.
- Ask at least 10 and at most 20 free-form questions.

Topics the LLM might probe:
- Key claims or arguments in the source
- Relationships to other concepts for cross-linking
- Context the user wants to add that the source doesn't capture
- Areas of disagreement, uncertainty, or nuance
- Contradictions or tensions with other concepts
- Practical implications or applications

### Step 5 — 4 constant questions

Ask these four questions **in order, one at a time**.
Do not proceed to the next until the user has answered.

For each question:
- Offer concrete answer options derived from the source content, the previous interview answers, and the existing concepts.
- Indicate your recommended option and justify why it fits.
- Wait for the user's input.
- If the user rejects your recommendation, let them explain why and try again.

**Question 1 — Type:**
```
What type of concept best describes this source?
```
Consider these defined types:
- `Definition` — states what a term or quantity means.
- `How-to` — tells the reader how to perform a task.
- `Pattern` — describes a recurring arrangement and why it holds.
- `Summary` — overviews an artifact or an idea.

Also list every type currently used in `bundle/*.md`, and prefer a type already in use.
Propose options the source could plausibly fit.

**Question 2 — Title (≤8 words):**
```
What is a concise title for this concept?
```
Propose short, descriptive titles.
Respect the 8-word limit.

**Question 3 — Description (≤16 words):**
```
What is a one-line description of this concept?
```
Propose descriptions that capture the essence.
Avoid adjectives, superlatives, or marketing language.
Respect the 16-word limit.

**Question 4 — Tags:**
```
What tags or categories should this concept carry?
```
List every tag already used in `bundle/*.md` before proposing.
Then propose alternative options, each a set of exactly 3 tags as a YAML list, preferring an existing tag to a new one, and recommend one.
Consider cross-cutting categories that help with discovery.

### Step 6 — Check for redundancy with existing concepts

Before writing, compare the planned concept against all existing documents in `bundle/`.

1. Read all `.md` files in `$HOME/repositorios/wiki/bundle/` (excluding `tmp.md`).
2. For each existing concept, assess whether the new concept's content overlaps semantically — shared claims, definitions, explanations, or examples.
3. Present a structured summary to the user:
   - List each existing concept with significant overlap.
   - For each, briefly describe which part of the new concept overlaps (1 line).
   - Recommend an action.
4. Offer the user the following options:
   - **Write with cross-links** — replace duplicated prose with standard markdown links to the existing concepts (e.g., `[Existing Concept](./existing.md)`).
   - **Skip** — the concept is sufficiently covered; do not write the document.
   - **Proceed as-is** — write the full content despite overlap.

   Wait for the user's choice before proceeding.

### Step 7 — Write bundle/tmp.md

Generate a valid OKF concept document at `$HOME/repositorios/wiki/bundle/tmp.md`.

**Frontmatter** (YAML, delimited by `---`):
- `type` — from Question 1 (non-empty string)
- `title` — from Question 2 (≤8 words)
- `description` — from Question 3 (≤16 words)
- `tags` — from Question 4 (3 tags as a YAML list)
- `resource` — the OKF field holding the source; always set. A URL if `$1` is a web source, a wiki-root-relative path (e.g. `raw/foo.pdf`) if `$1` is a local file, or `None` when there is no source. Refuse absolute or `~` paths: ask the user to copy the file into `raw/` or supply a relative one.

**Body:**
- Conform to the OKF spec and `AGENTS.md` rules:
  - One sentence per line
  - Each sentence ≤25 words
  - Total body ≤200 words (excluding frontmatter)
- Synthesise content from the source document (if any) and the interview answers.
- Do not duplicate content that is already present in other concepts.
  Link to existing concepts with standard markdown links instead.
- Write to `bundle/tmp.md` (not a permanent filename).

Present the generated content to the user for approval.
Show it clearly.
Ask:
- Does the content accurately reflect the source and our discussion?
- Any edits or refinements?

If the user requests changes, apply them and show the updated version.
Repeat until the user approves.

### Step 8 — Append to log.md

After the user approves the content, append one entry to `$HOME/repositorios/wiki/log.md`:

```markdown
## YYYY-MM-DD
- **Creation**: Added "[title]" from [source].
```
- `YYYY-MM-DD` — today's date in ISO 8601 format.
- `[title]` — the approved title from Question 2.
- `[source]` — the URL or file path provided as `$1`, or `None` when there is no source.
- Do not name the filename `tmp.md` — the user will rename it immediately.
- Append to the end of `log.md` (or insert under today's heading if one already exists).


### Step 9 — Verify OKF compliance

Verify that the generated `bundle/tmp.md` is a valid OKF concept document.
Use the following specification to check compliance:

- `https://raw.githubusercontent.com/GoogleCloudPlatform/knowledge-catalog/refs/heads/main/okf/SPEC.md` — the OKF specification

### Step 10 — Finish

Summarise what was done:
- Source ingested.
- Interview completed (N questions answered).
- `bundle/tmp.md` written and approved.
- `log.md` updated.

Remind the user of the next steps (out of scope of this command):
1. Rename `bundle/tmp.md` to the correct OKF filename.
2. Update `index.md` (if needed — it is auto-generated).
3. Commit the changes.

Do not commit.
Do not stage.
Do not modify `index.md`.
