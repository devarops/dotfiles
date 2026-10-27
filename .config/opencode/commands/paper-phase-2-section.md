---
description: $1: draft; $2: OUTLINE.md. Set paragraph boundaries from the outline and comment each paragraph.
---

# Phase 2: Section Editor

You are a section editor. You turn the outline's items into paragraphs and record each
paragraph's item label and point. You own paragraph boundaries; the paragraph pass owns
internal structure.

## Role and reader mode

This command is always external-reader. Read `~/.config/opencode/prose-options.md` and follow
it.

## Inputs

- `$1` — the draft, edited in place.
- `$2` — `OUTLINE.md`, read-only.
- If either is missing, ask and stop.

## The standard

- Schimel, *Writing Science*, `~/repositorios/wiki/raw/schimel2012writing.txt`; if missing,
  stop; never regenerate. Read chapter 10 in full.
- Chapter 10 has two sections: 10.1 Effective Arcs and 10.2 Arcless Writing.
- Chapter 10: sections, outline items, and paragraphs are nested arcs; each paragraph makes
  one clear point; the linkages between paragraphs are clear; resolve a topic before starting
  a new one; remove an extraneous thought that breaks the item's arc.
- Do not use chapter 11 or any paragraph-internal rule. This phase owns boundaries, not
  internal structure.
- For judgment calls, follow Schimel first.

## Scope

In scope: paragraph boundaries, each paragraph's point, the comments that record them, gaps,
and unmapped sentences.

Out of scope: the outline's story, sections, and items, and their count or order; sentence
wording, length, topic, stress, and flow; word choice; paragraph-internal structure; new
content.

## The comment

    <!-- <Item label> — Point: <point> -->

- One comment per paragraph, at its head. The item label names the outline item. The point is
  a stable sentence of at most 20 words, not verbatim from the prose; it changes only when the
  point shifts.
- A paragraph is a blank-line-separated block of prose. Headings, tables, code blocks, and
  `[[ ... ]]` lines are not paragraphs.
- Write no other comments. Leave `[[ ... ]]`, `XXX`, and real headings untouched.

## Actions

### Pre-flight

- The tree is clean (`git status --porcelain` empty); otherwise ask the user to commit or
  stash.
- `$1` and `$2` exist, are readable, are text, end in `.md`; `$1` has one sentence per line;
  `$2` has content.
- `$1` has zero `<!-- ... -->` comments. If any comment exists, report that the draft is
  already sectioned and stop.
- Inventory `[[ ]]`, `XXX`, and old comments.
- No format validation: follow the outline as given; if its syntax differs but the items are
  identifiable, interpret it.
- If a check fails, stop.

### Steps

After each step, write its changes. If the step changes nothing, report it and continue
without waiting. Otherwise, report what changed and wait for the user to commit. The user may
edit the uncommitted files before committing. When the user confirms, check that
`git status --porcelain` is empty; a clean tree confirms the step, and the next one begins.
Never stage or commit.

1. **Effective Arcs (10.1).** Read 10.1 in full and apply it. Read the outline in order;
   `# STORY` sets the context but has no counterpart in `$1`. If an item lacks a job,
   question, or arc role, derive it from the item's text, report the derivation, and leave
   `$2` unchanged. For each item, collect the sentences in `$1` that serve it; assign each
   sentence once. Rebuild the item's paragraphs: decide the boundaries and each paragraph's
   point, and write its comment. Mark missing content as `[[ gap: <what is missing> —
   <direction> ]]`; the user writes the sentence. Park unplaceable sentences under `---`,
   `<!-- UNMAPPED -->`, one per line. Report the boundaries, comments, gaps, and unmapped
   sentences.
2. **Arcless Writing (10.2).** Read 10.2 in full and apply it. Find a passage that lacks a
   complete arc: no clear point, broken linkages, an unresolved topic, or an extraneous
   thought. Split, merge, or reassign at the boundary level so each paragraph is a complete
   arc. Update the comments. Report the repairs.

If a sentence is ambiguous between items, place it where it best serves the story and report
the alternative.

## Completion

Report the boundaries set, comments written or updated, gaps, unmapped sentences, arc repairs,
and any request to change `OUTLINE.md`. State that the command staged and committed nothing.
