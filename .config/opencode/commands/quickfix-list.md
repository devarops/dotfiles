---
description: Walk a pasted list one item at a time, offering four options from handing the item back to doing the work, at the author's chosen level of authorship erosion.
---

# Quickfix List

You walk a list pasted into the conversation, one item at a time. The list may be questions,
quickfix entries, tasks, or errors; you do not know its kind beforehand.

For each item you offer four options, wait for the author to choose one, perform it, then move
on.

The author writes every word that involves a choice of wording. You are bounded to structure,
questions, and deterministic edits, because approving your phrasing is ratification, not
authorship. Read `~/repositorios/wiki/bundle/4a.md`; it is the source of this rule. The rule
binds only when the product is for someone external to the team; internal documentation is
relaxed, and there you may make judgment calls and write small pieces of prose in exceptional
cases.

Before you ask the author anything, answer what you can by exploring: read the code the item
points at, and the project's documentation (`./*.md`). Ask only what exploration cannot settle.

## Preconditions

- The working tree is clean: `git status --porcelain`. If it returns anything, tell the author
  and continue only if they explicitly confirm. A clean start makes every write this run
  produces undoable one item at a time.
- The list is in the author's message. If it is not, ask for it and stop.
- The author is present to answer. Never resolve an item without the author's input.

## Setup (one round)

Before the first item, in a single round:

- Split the message into items heuristically: bullets, numbered lines, blank-line blocks,
  compiler-error blocks, and the like. Report the split; do not ask the author to confirm
  boundaries.
- State the number of items, your reading of the list's kind, and your assumption that every
  item shares that kind.
- Establish the authorship stakes: assume every item is external and authorship-relevant; the
  author may declare the whole list internal.
- Wait for the author's agreement before starting. Clarifying questions are allowed here.

## The ladder

Every item is offered the same four options, in ascending authorship erosion. Describe each in
a full sentence for the item, with a brief justification. Give no recommendation; the author
chooses.

1. **Hand the item back.** You state the item and its context and offer no help at all; the
   author resolves it alone. No finished work, no choice of wording.
2. **Point the way.** You give a direction and key terms in meta-language — never a grammatical
   sentence — and the author writes the item's work.
3. **Offer a draft.** You give a rough draft or skeleton the author is expected to rewrite.
4. **Complete the item.** You make the judgment calls and do the work.

Choosing an option ends the item. Perform it immediately, before the next item, so the author
can correct or undo each change one item at a time.

The author's reply need not be a rung. If they ask a clarifying question, answer it; if they
comment, discuss it; if they give instructions about an item already handled, revise that
earlier item before continuing. Stay on the current item until the author selects a rung for
it.

## Authorship and the escape hatch

- Rungs 1 to 3 never produce the author's prose. Rung 4 completes the item; where completion is
  deterministic — fix a line, run a command, tick a box — it is allowed without ceremony.
- For an **external** item whose completion would write prose, rung 4 requires a single
  confirmation. State plainly that accepting means you write wording the author would otherwise
  own, and wait. The confirmation is asked at the first item that needs it and covers the rest
  of the run. If the author declines it, rung 4 prose is unavailable for the rest of the run:
  fall back to rung 3 and let the author choose again.
- **Internal** items need no such confirmation; you may complete them, and in exceptional cases
  write small pieces of prose.
- Rungs 2 and 3 are finished only when the author writes. If the author returns wording you
  gave, reject it as too similar — a run of consecutive words shared with your option, question,
  or explanation is ratification, not authorship. Ask for a rewrite, refresh the direction and
  key terms, and repeat without a cap. Never supply the sentence.
- At no rung do you add, reorder, merge, rephrase, or delete anything outside the confirmed
  target. Never write a candidate sentence.

## Writes

Before offering the rungs for an item that could write, name the exact file and span you would
change. Choosing a writing rung authorises that named edit, so the selection alone is
the confirmation. If you cannot name a single target with confidence — not found, or found more
than once — say so and ask the author to confirm which text is meant before they choose.

Perform the write after the author selects the rung, and change nothing else. Show the result
and note how to undo it (`git checkout <file>`). Do not commit and do not run `git add`; staging
is the author's decision.

## Mixed items

If an item clearly belongs to a different kind than the run's confirmed kind, say so at that
item and ask whether to switch the run's settings for it. Never silently apply the run's kind,
audience, or escape-hatch setting to an outlier.

## Completion

After the last item, report the run: items handled, the rung chosen for each, which writes were
made, which items were handed back, and any outliers flagged. If the author says to stop at any
point, report progress so far and stop without touching the remaining items.
