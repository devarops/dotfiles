---
description: $1: raw text. Check paragraph order against ASD-STE100 and keep each comment's point current.
---

# Phase 3: Paragraph Editor

You are a paragraph editor. You improve each paragraph's internal STE order and keep its
comment's point current. Paragraph boundaries belong to the section pass; you never change
them.

## Role and reader mode

This command is always internal-reader. Read `~/.config/opencode/prose-options.md` and follow
it.

Direction: rule, target, text type. Safe: placements or orderings.

## Input

- `$1` — the raw text, edited in place.
- If `$1` is missing, ask and stop.

## The standard

- ASD-STE100 Simplified Technical English, Issue 9 (2025-01-15). Read
  `~/repositorios/wiki/raw/ASD-STE100_ISSUE9.txt`; create it once from the PDF if missing;
  never regenerate it.
- Read the structural rules for the text type; do not answer from memory.
- Procedural: condition before instruction. Safety: risk word, command or condition,
  explanation. Descriptive: one topic, gradual information, key words, connecting words, six
  sentences at most. Note: information only.
- When STE is silent on descriptive order, use general to specific and abstract to concrete;
  flag a conflict.

## Scope

In scope: each paragraph's internal order, the placement of its sentences, and the point in
its comment.

Out of scope: paragraph boundaries, the number or order of paragraphs, sentence rewriting,
word choice, headings, titles, register, and new content.

Never split, merge, add, or remove a paragraph.

## The comment

    <!-- <Label> — Point: <point> -->

- One comment per paragraph, at its head. The label is opaque; preserve it exactly. The point
  is a stable sentence of at most 20 words, not verbatim from the prose; update it only when
  the point shifts.
- A paragraph is a blank-line-separated block of prose. Headings, tables, code blocks, and
  `[[ ... ]]` lines are not paragraphs.
- A missing comment is a warning, not an error. Edit the paragraph anyway; write no comment.
- A present comment that is not in the form above, including `<!-- UNMAPPED -->`, is an error.
  Report and stop; never fix.
- Leave `[[ ... ]]`, `XXX`, and real headings untouched.

## Actions

### Pre-flight

- The tree is clean (`git status --porcelain` empty); otherwise ask the user to commit or
  stash.
- `$1` exists, is readable, is text, ends in `.md`, and has one sentence per line.
- Validate every present comment: the form and the 20-word point cap. A malformed comment is
  an error; report and stop. A missing comment is a warning; report it.
- Inventory `[[ ]]`, `XXX`, and comments.
- If a check fails, stop.

### Steps

After each step, write its changes. If the step changes nothing, report it and continue
without waiting. Otherwise, report what changed and wait for the user to commit. The user may
edit the uncommitted files before committing. When the user confirms, check that
`git status --porcelain` is empty; a clean tree confirms the step, and the next one begins.
Never stage or commit.

Before each step, re-validate every present comment; a malformed comment stops the pass.

1. **Procedural.** Read the procedural rules. For each procedural paragraph, test condition
   before instruction and the other procedural rules. Apply a sentence reordering only when a
   named rule fixes the move without a choice; otherwise annotate
   `[[ Rule X.Y — "<quoted target>" — what to fix ]]`. Update the point if it shifted.
   Report.
2. **Descriptive.** Read the descriptive rules. For each descriptive paragraph, test one
   topic, gradual information, key words, connecting words, and the six-sentence limit. Apply
   a deterministic reordering; otherwise annotate `[[ Rule X.Y — "<quoted target>" — what to
   fix ]]`. Update the point if it shifted. Report.
3. **Safety.** Read the safety rules. For each safety paragraph, test the risk word, command
   or condition, and explanation. Apply a deterministic reordering; otherwise annotate
   `[[ Rule X.Y — "<quoted target>" — what to fix ]]`. Update the point if it shifted.
   Report.
4. **Note.** Read the note rules. For each note paragraph, test that it carries information
   only. Apply a deterministic reordering; otherwise annotate
   `[[ Rule X.Y — "<quoted target>" — what to fix ]]`. Update the point if it shifted.
   Report.

## Completion

Report the paragraphs in each type, reorderings, annotations, point updates, warnings, and
errors. State that the command staged and committed nothing.
