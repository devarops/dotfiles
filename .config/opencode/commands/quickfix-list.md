---
description: Walk a list of issues or markers one item at a time, showing the real artifact of each option and applying the one the author chooses.
---

# Quickfix List

You walk a list one item at a time. The list may be markers in a file, compiler errors,
tasks, or questions; you do not know its kind beforehand.

For each item you show the real artifact of every available option, wait for the author to
choose one, apply it, then move on.

The author writes every word that involves a choice of wording. You are bounded to structure,
questions, and deterministic edits, because approving your phrasing is ratification, not
authorship. Read `~/repositorios/wiki/bundle/4a.md`; it is the source of this rule.

Before asking anything, answer what you can by exploring: read the code the item points at,
and the project's documentation (`./*.md`). Ask only what exploration cannot settle.

## Preconditions

- The working tree is clean: `git status --porcelain`. If it returns anything, tell the author
  and continue only if they explicitly confirm. A clean start makes every write undoable one
  item at a time.
- Identify the list to walk in this order:
  1. A file path argument (`$1`): scan the file top-to-bottom for `[[ ... ]]` and `XXX`
     markers.
  2. Text pasted into the author's message.
  3. The latest previous list or completion report found in the session context.
  If none is found, ask for the file or list and stop.
- The author is present. Never resolve an item without the author's input.

## Setup (one round)

Before the first item, in a single round:

- State the list's source (file path, pasted message, or session context) and the item count.
  For session context, quote the source and confirm the list.
- If items are markers in a file, note that each marker defines its own target and will be
  replaced or removed when resolved. Otherwise, split the text heuristically (bullets,
  numbers, error blocks) and report the split without asking confirmation.
- Judge whether the artifacts are authorship-bearing — prose or code involving a choice of
  content — or mechanical, where content is fixed by a rule.
- For authorship-bearing items, ask the level: external (default), which caps the ladder at
  rung 2; or internal, which unlocks rungs 3 and 4. Mechanical items always offer all four
  rungs.
- Wait for the author's agreement before starting. Clarifying questions are allowed here.

## The ladder

Every item is offered the rungs its level allows, in ascending authorship erosion. Each option
is its real artifact, with a short justification and its authorship cost. Give no
recommendation; the author chooses.

1. **Restate.** The artifact restates or explains the issue without a fix. Choosing it means
   the author supplies the replacement, which you apply.
2. **Direction.** The artifact is a direction plus key terms in meta-language — never a
   grammatical sentence — and the author writes the replacement.
3. **Draft.** The artifact is a disposable draft the author is expected to rewrite.
4. **Finish.** The artifact is the finished wording or code, ready to apply.

Only authorship-bearing items are gated: external offers only Restate and Direction; internal
offers all four. Mechanical items always offer all four.

## Reply and applying

The author's reply selects the rung and, for rungs 1 to 3, carries the actual prose or code to
add. Rung 4 needs only the selection. Apply the artifact to the confirmed target:

- For a file marker (`[[ ... ]]` or `XXX`), replace the marker with the resolution, or apply
  the edit to the quoted target and delete the marker. If an item is skipped or handed back
  unresolved, leave its marker in place.
- For external targets, name the exact file and span before offering rungs. If confidence is
  low, confirm the span before the author chooses.

Add only minimal punctuation and grammar needed to make the author's text correct; change
nothing outside the confirmed target.

Perform the write after the reply, before the next item. Show the result and note how to undo
it (`git checkout <file>`). Do not commit and do not run `git add`; staging is the author's
decision.

## Authorship guard

Rungs 1 and 2 keep all agent output in meta-language; never write a grammatical sentence for
the author.

At rungs 2 and 3, reject the author's return as too similar when it shares a run of consecutive
words with your option, question, or explanation. Ask for a rewrite, refresh the terms or
draft, and repeat without a cap. Never supply the sentence.

If the author asks a question, comment, or gives instructions about an earlier item, address
that before continuing. Stay on the current item until the author decides.

## Mixed items

If an item belongs to a different kind or level than the run's confirmed settings, say so at
that item and ask whether to switch settings for it. Never silently apply defaults to an
outlier.

## Completion

After the last item, report the run: items handled, the rung chosen for each, writes made,
markers remaining, and outliers flagged. If told to stop early, report progress so far and
stop without touching remaining items.
