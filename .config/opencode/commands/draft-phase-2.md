---
description: Resolve annotations by interviewing the author, adding content to gaps or rewriting text the annotation points at.
---

# Phase 2: Resolve Annotations

- The target Markdown file is provided as `$ARGUMENTS`.
- An annotation is any `[[ ... ]]` or `XXX` marker. Every annotation requires the author's input; none is resolved without it.

## Two kinds of annotation

- **Add content.** The annotation marks a gap. The author's answer is written in place of the annotation.
- **Rewrite content.** The annotation points at existing text. The author's answer replaces that text, and the annotation is removed with it.

## Authorship

The author must author the prose. The agent prompts and guides, but never writes the
sentence, because authorship and accountability belong to the author.

- The agent never writes a candidate sentence. Except for the minimal completion
  permitted under Asking, all agent output is meta-language: a direction, key terms,
  and justification.
- An option is a direction plus key terms, never a grammatical sentence. Its key
  terms must add at least one fact or distinction absent from the annotation and the
  question.
- An answer is rejected as too similar when it shares a run of consecutive words
  with an option, the question, or the agent's explanation.
- On rejection, ask the author to rewrite, and refresh the direction and key terms
  to offer more options. Never supply a sentence. Repeat without a cap.

## Structure preservation

Each paragraph is arranged as one point in Topic → Evidence → Explanation → Link
order, Schimel's paragraph-as-mini-story. An unresolved annotation marks a missing
role at its position.

- Identify the role the annotation occupies before asking; frame the question for
  that role.
- An answer must serve that role: a topic states the paragraph's point, evidence
  supplies a fact, explanation connects evidence to topic, and a link transitions.
- If the answer does not serve the role, ask the author to rewrite. Do not accept it
  and do not restructure.
- After insertion, the paragraph must still hold exactly one point with the four
  roles in order, and nothing may be added outside the confirmed target.

## Asking

- For each annotation found in the file:
  - state your reading of the annotation and the exact text you take to be its target,
  - ask the corresponding question,
  - offer options, each a direction plus key terms, never a sentence,
  - indicate your recommended direction, never a sentence,
  - justify your recommendation, and
  - wait for the author's input.
- Locate the annotation's target as best you can. If it is not found, or found more than once, say so and ask the author to confirm which text is meant. Never resolve an annotation against a target the author has not confirmed.
- If an annotation names more than one target, confirm each, and apply one answer to all of them.
- Present one annotation at a time. Move to the next one only after the author has provided input for the current one.
- Apply the Authorship rules when offering options and when accepting an answer.
- Fix spelling and grammar in the author's answer and complete a fragment with at most 5 function words. Change no content word and no meaning.
- If the author rejects your recommendation, let them explain why and try again.

## Applying an answer

- **Add content:** write the answer where the annotation is, replacing the annotation.
- **Rewrite content:** write the answer in place of the confirmed target, and remove the annotation.
- Change nothing else.

## What this phase does not do

- Do not generate content. Apply the author's words; do not supply your own.
- Do not write a candidate sentence; keep all agent output in meta-language.
- Do not create new annotations.
- Do not alter, reorder, merge, rephrase, or delete anything outside the confirmed target.

## Pass summary

- After reaching the end of the file, print:
  - `Pass N complete. X annotations resolved, Y annotations still remain. Start pass N+1?`
- If 0 annotations were resolved or 0 annotations remain, print a completion message and stop. Otherwise, wait for the author to confirm the next pass.
- Commit after each pass.
