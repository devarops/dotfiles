---
description: Remove one open item immediately and report it.
---

# Remove an Open Item

No argument is declared. Take the item from the conversation: a number, a description, or an unambiguous reference. If the reference is missing or ambiguous, show the numbered list and ask. Do not guess.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md`. If it is absent or has no matching item, report and stop. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line.

## Remove

Precondition: the item exists in `.OPEN.md`.

- Remove the description line and, when present, its `Test:` line.
- If the removed item was `[*]`, leave no focused item.
- Do not touch any other item.
- Write the file immediately. Do not ask for a reason and do not confirm. Do not stage or commit.

## Report

Report the removed description, whether it was focused, and the remaining item count. State that nothing was staged or committed.

## Idempotency

The durable action is the removal. Its precondition is that the item exists; after the write, it is absent. A second run on the same item reports that it is not found and writes nothing.
