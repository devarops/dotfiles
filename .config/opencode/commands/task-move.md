---
description: Move one open item into the TODO.md list.
---

# Move an Open Item

No argument is declared. Take the item from the conversation: a number, a description, or an unambiguous reference. If the reference is missing or ambiguous, show the numbered list and ask. Do not guess.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md` and `<root>/TODO.md`. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line in `.OPEN.md`.
- The item must exist and have a `Test:` line. If it lacks one, report and stop; do not move it.

## Destination

- `TODO.md` is a single flat ordered list; it has no `##` sections. Read its entries and append the item at the end, or insert it where the user names.
- If `TODO.md` is absent, ask once to create it with `# Backlog`. If the user declines, report and leave the item in `.OPEN.md`.
- Write the item in the `.OPEN.md` format:

```
- [ ] <description>
      Test: <test>
```

- Place it at the end of the list, after the last item.

## Write

Precondition: the item exists in `.OPEN.md` and the same normalized description is absent from `TODO.md`.

- `TODO.md` may be dirty; insert the item and preserve the rest of the file.
- Write `TODO.md` first.
- Then remove the item from `.OPEN.md` and clear `[*]` if it was focused.
- If the `TODO.md` write fails, leave `.OPEN.md` unchanged.
- Do not stage or commit.

## Report

Name the position, the exact two-line entry, whether `# Backlog` or `TODO.md` was created, and whether focus was cleared. State that nothing was staged or committed.

## Idempotency

The durable action is the move. Its precondition is that the item exists in `.OPEN.md` and the entry is absent from `TODO.md`; after the move, both conditions are false. A second run on the same item reports that it is no longer open and writes nothing.
