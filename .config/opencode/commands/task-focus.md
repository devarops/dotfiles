---
description: Mark one open item as the current focus.
---

# Focus an Open Item

No argument is declared. Take the item from the conversation: a number, a description, or an unambiguous reference. If the reference is missing or ambiguous, show the numbered list and ask. Do not guess.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md`. If it is absent or has no items, report and stop. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line.

## Validate

- The chosen item must have a `Test:` line. If it does not, report the item and stop without writing.
- If more than one `[*]` exists, report the malformed state and stop; do not guess which focus to keep.
- If the chosen item is already the only `[*]`, report `already focused` and stop without writing.

## Write

Precondition: the chosen item is not already the only focused item.

- Change the chosen item's `[ ]` to `[*]`.
- Change the previous `[*]` to `[ ]`, if one exists.
- Write the file once. Do not change the item's text, Test, or position.
- Print the focused item and its Test. Do not stage or commit.

## Report

Name the focused item and the previous focus, if any. State that nothing was staged or committed.

## Idempotency

The durable action is the marker change. Its precondition is that the chosen item is not already the only focus; after the write, it is false. A second run reports `already focused` and writes nothing.
