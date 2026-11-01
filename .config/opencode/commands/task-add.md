---
description: Add a two-line item to the session open list.
---

# Add an Open Item

No argument is declared. The item is whatever the conversation has surfaced.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- The target is `<root>/.OPEN.md`.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `.OPEN.md` when it exists. Skip headers and stray text. An item is a line matching `- [ ] ` or `- [*] `; its `Test:` is the next line when it starts with six spaces and `Test:`.

## Item

- Take the description from the conversation. If it is absent or ambiguous, ask for it.
- Take the Test from the conversation. If it is absent, ask for it. Never write a placeholder and never propose the Test.
- Both must be non-empty. Flatten each to one line. Write only after both are non-empty.
- Do not add or remove punctuation from the user's wording.
- Compare the new description with every existing description after trimming and collapsing whitespace. If one matches exactly, report that item and stop without writing.

## Write

Precondition: no existing item has the same normalized description.

- If `.OPEN.md` is absent, create it.
- Ensure the file ends with a newline, then append:

```
- [ ] <description>
      Test: <test>
```

- Do not add a header. Do not set focus. Do not touch `TODO.md`. Do not stage or commit.

## Report

Report the added description and Test, the resulting item count, and that nothing was staged or committed. If the item already existed, report the existing item and write nothing.

## Idempotency

The only durable action is the append. Its precondition is that no item has the same normalized description; after the append, that precondition is false. A second run on the same item reports it and writes nothing.
