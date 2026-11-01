---
description: Show the session open items with numbers, focus, and Tests.
---

# List Open Items

No argument is declared. The list is the conversation's open list.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md`. If it is absent or has no items, report `No open items` and stop. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line.

## Display

Number the valid items in file order. For each item, show:

```
1. [*] Description of the task or issue.
       Test: The definition of done.
```

- `[*]` marks the focused item; `[ ]` marks every other item.
- Use seven spaces before `Test:` so it aligns under the description.
- If an item has no `Test:` line, show `Test: (missing)`.
- After the list, report the total item count and the focused item number, if any. If more than one `[*]` exists, report the malformed state.

Never write, stage, or commit.

## Idempotency

The command is read-only and performs no durable action.
