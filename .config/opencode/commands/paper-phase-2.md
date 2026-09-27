---
description: Resolve annotations by interviewing the author, adding content to gaps or rewriting text the annotation points at.
---

# Phase 2: Resolve Annotations

- The target Markdown file is provided as `$ARGUMENTS`.
- Read `schimel-rules.md`. It is your only source of Schimel's principles.
- An annotation is any `[[ ]]` or `XXX` marker. Every annotation requires the
  author's input. None is resolved without it.

## Two kinds of annotation

- **Add content.** The annotation marks a gap. The author's answer is written in
  place of the annotation.
- **Rewrite content.** The annotation points at existing text. The author's answer
  replaces that text, and the annotation is removed with it.

## Arc elements

Each paragraph is one point carried by an arc: **O** names the topic, **C-A** carries
the event, **R** delivers the outcome. An unresolved annotation marks a missing
element of that arc at its position.

- Identify which element the annotation occupies before asking, and frame the question
  for it.
- An answer must serve that element. An opening sets the topic and should be something
  the reader already holds; a challenge-action supplies the event; a resolution
  delivers the outcome, and in a point-last paragraph it states the paragraph's point.
- If the answer does not serve the element, ask the author to rewrite. Do not accept it
  and do not restructure.
- After insertion the paragraph must still carry exactly one point with its arc in
  order, and nothing may be added outside the confirmed target.

## Authorship

The author must write every word. The agent prompts and guides but never writes the
sentence, because authorship and accountability belong to the author.

- The agent never writes a candidate sentence. All agent output is meta-language: a
  direction, key terms, and a justification.
- An option is a direction plus key terms, never a grammatical sentence. Its key terms
  must add at least one fact or distinction absent from the annotation and the question.
- An answer is rejected as too similar when it shares a run of consecutive words with
  an option, the question, or the agent's explanation. Rejection means the author
  ratified your phrasing rather than writing it, which defeats the purpose.
- On rejection, ask the author to rewrite, and refresh the direction and key terms to
  offer more options. Never supply a sentence. Repeat without a cap.

## Asking

For each annotation found in the file, in order:

- state your reading of the annotation and the exact text you take to be its target;
- name the arc element the annotation occupies;
- ask the question that element calls for;
- offer options, each a direction plus key terms, never a sentence;
- indicate your recommended direction, never a sentence;
- justify the recommendation, citing the rule from `schimel-rules.md` that prompted
  it;
- wait for the author's input.

Locate the annotation's target as best you can. If it is not found, or is found more
than once, say so and ask the author to confirm which text is meant. Never resolve an
annotation against a target the author has not confirmed. If an annotation names more
than one target, confirm each, and apply one answer to all of them.

Present one annotation at a time. Move to the next only after the author has provided
input for the current one. If the author rejects your recommendation, let them explain
why and try again.

## Applying an answer

- **Add content:** write the answer where the annotation is, replacing the annotation.
- **Rewrite content:** write the answer in place of the confirmed target, and remove
  the annotation.
- Change nothing else.

## What this phase does not do

- Do not generate content. Apply the author's words; do not supply your own.
- Do not write a candidate sentence; keep all agent output in meta-language.
- Do not create new annotations.
- Do not alter, reorder, merge, rephrase, or delete anything outside the confirmed
  target.

## Completion

Report how many annotations were resolved and how many remain. If none were resolved
or none remain, say so and stop. Otherwise leave the unresolved annotations in place,
with their targets quoted, and let the author decide what runs next.

Commit after each pass.
