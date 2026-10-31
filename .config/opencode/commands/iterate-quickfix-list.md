---
description: Walk a list one item at a time.
---

# Quickfix List

You walk a list one item at a time. The list may be markers in a file, compiler errors,
tasks, or questions; you do not know its kind beforehand.

For each item, read and follow `~/.config/opencode/prose-options.md`. Show the actual
artifact of every alternative, never a description.

Before asking anything, answer what you can by exploring: read the code the item points at,
and the project's documentation (`./*.md`). Ask only what exploration cannot settle.

## Preconditions

- The working tree is clean: `git status --porcelain`. If it returns anything, tell the user
  and continue only if they explicitly confirm. A clean start makes every write undoable one
  item at a time.
- Identify the list to walk in this order:
  1. A file path argument (`$1`): scan the file top-to-bottom for `[[ ... ]]` and `XXX`
     markers.
  2. Text pasted into the user's message.
  3. The latest previous list or completion report found in the session context.
  If none is found, ask for the file or list and stop.
- The user is present. Never resolve an item without the user's input unless the fix is
  deterministic.

## Setup (one round)

Before the first item, in a single round:

- State the list's source (file path, pasted message, or session context) and the item count.
  For session context, quote the source and confirm the list.
- If items are markers in a file, note that each marker defines its own target and will be
  replaced or removed when resolved. Otherwise, split the text heuristically (bullets,
  numbers, error blocks) and report the split without asking confirmation.
- This command may be either mode.
- Wait for the user's agreement before starting. Clarifying questions are allowed here.

## Deterministic fixes

Apply a deterministic fix without asking and report it in the completion. Every other fix
waits for the user's choice.

## Artifacts

Name the exact file and span before offering a direction. If confidence is low, confirm the
span before the user chooses.

- **Direction.** The target, the issue, and the key terms or constraints.
- **Safe.** A safe alternative, as defined in `prose-options.md`.
- **Finished.** Fixes.

## Reply and applying

- For a file marker (`[[ ... ]]` or `XXX`), replace the marker with the resolution, or apply
  the edit to the quoted target and delete the marker. If an item is skipped or handed back
  unresolved, leave its marker in place.

Add only minimal punctuation and grammar needed to make the user's text correct.

Perform each write before the next item. Do not commit and do not run
`git add`; staging is the user's decision.

## Guard

Follow the guard in `prose-options.md`.

If the user asks a question, comment, or gives instructions about an earlier item, address
that before continuing. Stay on the current item until the user decides.

## Completion

After the last item, report the run: items handled, the user's choice for each item that
required one, the deterministic fixes applied without asking, writes made, and markers
remaining. If told to stop early, report progress so far and stop without touching remaining
items.
