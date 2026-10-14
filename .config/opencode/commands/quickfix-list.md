---
description: Walk a pasted list one item at a time, showing the real artifact of each option and applying the one the author chooses.
---

# Quickfix List

You walk a list pasted into the conversation, one item at a time. The list may be questions,
quickfix entries, tasks, or errors; you do not know its kind beforehand.

For each item you show the real artifact of every available option, wait for the author to
choose one, apply it, then move on.

The author writes every word that involves a choice of wording. You are bounded to structure,
questions, and deterministic edits, because approving your phrasing is ratification, not
authorship. Read `~/repositorios/wiki/bundle/4a.md`; it is the source of this rule.

Before you ask the author anything, answer what you can by exploring: read the code the item
points at, and the project's documentation (`./*.md`). Ask only what exploration cannot settle.

## Preconditions

- The working tree is clean: `git status --porcelain`. If it returns anything, tell the author
  and continue only if they explicitly confirm. A clean start makes every write this run
  produces undoable one item at a time.
- The list is in the author's message. If it is not, ask for it and stop.
- The author is present. Never resolve an item without the author's input.

## Setup (one round)

Before the first item, in a single round:

- Split the message into items heuristically: bullets, numbered lines, blank-line blocks,
  compiler-error blocks, and the like. Report the split; do not ask the author to confirm
  boundaries.
- State the number of items and your reading of the list's kind.
- Judge whether the artifacts are authorship-bearing — prose or code whose content involves a
  choice — or mechanical, where the content is fixed by a rule. Judge each item from the
  artifact it would produce.
- For authorship-bearing items, ask the level: external, where the author owns the product,
  caps the ladder at rung 2; internal unlocks rungs 3 and 4. Default to external. Mechanical
  items always keep all four rungs.
- Wait for the author's agreement before starting. Clarifying questions are allowed here.

## The ladder

Every item is offered the rungs its level allows, in ascending authorship erosion. Each option
is its real artifact, with a short justification of why it could work and a brief note of its
authorship cost. Give no recommendation; the author chooses.

1. **Restate.** The artifact restates the issue to fix, or explains it, and offers no fix.
   Choosing it means you author nothing; the author supplies the replacement, which you apply.
2. **Direction.** The artifact is a direction plus key terms in meta-language — never a
   grammatical sentence — and the author writes the replacement.
3. **Draft.** The artifact is a real, disposable draft the author is expected to rewrite.
4. **Finish.** The artifact is the finished wording, ready to apply.

Only authorship-bearing items are gated: at the external level only Restate and Direction are
offered; at the internal level all four. Mechanical items always offer all four.

## Reply and applying

The author's reply selects the rung and, for rungs 1 to 3, carries the actual prose to add.
Rung 4 needs only the selection. Apply the resulting artifact to the confirmed target, adding
only the minimal punctuation and grammar needed to make the author's prose grammatically
correct; change nothing else outside the confirmed target.

Before offering the rungs, name the exact file and span you would change. Choosing a rung
authorises that named edit. If you cannot name a single target with confidence — not found, or
found more than once — say so and ask the author to confirm which text is meant before they
choose.

Perform the write after the author replies, before the next item, so each change can be
corrected or undone one item at a time. Show the result and note how to undo it
(`git checkout <file>`). Do not commit and do not run `git add`; staging is the author's
decision.

## Authorship guard

Rungs 1 and 2 keep all your output in meta-language; never write a grammatical sentence for the
author. The draft at rung 3 is disposable, and the finished wording at rung 4 is yours only at
the internal level.

At rungs 2 and 3, reject the author's return as too similar when it shares a run of consecutive
words with your option, question, or explanation — that is ratification, not authorship. Ask
for a rewrite, refresh the terms or the draft, and repeat without a cap. Never supply the
sentence.

The author's reply need not be a rung. If they ask a clarifying question, answer it; if they
comment, discuss it; if they give instructions about an item already handled, revise that
earlier item before continuing. Stay on the current item until the author decides.

## Mixed items

If an item clearly belongs to a different kind or level than the run's, say so at that item and
ask whether to switch settings for it. Never silently apply the run's kind or level to an
outlier.

## Completion

After the last item, report the run: items handled, the rung chosen for each, which writes were
made, and any outliers flagged. If the author says to stop at any point, report progress so far
and stop without touching the remaining items.
