---
description: Resolve annotations by interviewing the author, adding content to gaps or rewriting text the annotation points at.
---

# Phase 2: Resolve Annotations

- The target Markdown file is provided as `$ARGUMENTS`.
- An annotation is any `[[ ... ]]` or `XXX` marker. Every annotation requires the author's input; none is resolved without it.

## Two kinds of annotation

- **Add content.** The annotation marks a gap. The author's answer is written in place of the annotation.
- **Rewrite content.** The annotation points at existing text. The author's answer replaces that text, and the annotation is removed with it.

## Asking

- For each annotation found in the file:
  - state your reading of the annotation and the exact text you take to be its target,
  - ask the corresponding question,
  - offer options for answers,
  - indicate your recommended answer,
  - justify your recommendation, and
  - wait for the author's input.
- Locate the annotation's target as best you can. If it is not found, or found more than once, say so and ask the author to confirm which text is meant. Never resolve an annotation against a target the author has not confirmed.
- If an annotation names more than one target, confirm each, and apply one answer to all of them.
- Present one annotation at a time. Move to the next one only after the author has provided input for the current one.
- The options for each annotation should be concise phrases that capture the essence of the answer, not full sentences.
- Fix grammar and spelling in the author's answer before writing it in place, but limit changes to only those necessary for clarity and correctness.
  - If the author's answer is a fragment, add the minimum number of words needed to make it a complete sentence.
  - Do not add more than is necessary.
- If the author rejects your recommendation, let them explain why and try again.

## Applying an answer

- **Add content:** write the answer where the annotation is, replacing the annotation.
- **Rewrite content:** write the answer in place of the confirmed target, and remove the annotation.
- Change nothing else.

## What this phase does not do

- Do not generate content. Apply the author's words; do not supply your own.
- Do not create new annotations.
- Do not alter, reorder, merge, rephrase, or delete anything outside the confirmed target.

## Pass summary

- After reaching the end of the file, print:
  - `Pass N complete. X annotations resolved, Y annotations still remain. Start pass N+1?`
- If 0 annotations were resolved or 0 annotations remain, print a completion message and stop. Otherwise, wait for the author to confirm the next pass.
- Commit after each pass.
