---
description: Move one open item into the best-fitting TODO.md section.
---

# Move an Open Item

No argument is declared. Take the item from the conversation: a number, a description, or an unambiguous reference. If the reference is missing or ambiguous, show the numbered list and ask. Do not guess.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md` and `<root>/TODO.md`. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line in `.OPEN.md`.
- The item must exist and have a `Test:` line. If it lacks one, report and stop; do not move it.

## Destination

- The current structure of `TODO.md` is authoritative. Read its headings and existing entries and choose the section that best fits the item's description and Test.
- If no section fits, use `# Backlog`. If `# Backlog` is absent, create it at the end of `TODO.md` after a blank line.
- If `TODO.md` is absent, ask once to create it with `# Backlog`. If the user declines, report and leave the item in `.OPEN.md`.
- Write the item in the `.OPEN.md` format, even when the target uses another indentation:

```
- [ ] <description>
      Test: <test>
```

- Place it at the end of the chosen section, before the next heading.

## Write

Precondition: the item exists in `.OPEN.md` and the same normalized description is absent from `TODO.md`.

- `TODO.md` may be dirty; insert the item and preserve the rest of the file.
- Write `TODO.md` first.
- Then remove the item from `.OPEN.md` and clear `[*]` if it was focused.
- If the `TODO.md` write fails, leave `.OPEN.md` unchanged.
- Do not stage or commit.

## Report

Name the chosen heading, the exact two-line entry, whether `# Backlog` or `TODO.md` was created, and whether focus was cleared. State that nothing was staged or committed.

## Idempotency

The durable action is the move. Its precondition is that the item exists in `.OPEN.md` and the entry is absent from `TODO.md`; after the move, both conditions are false. A second run on the same item reports that it is no longer open and writes nothing.
