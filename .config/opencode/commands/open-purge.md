---
description: Remove open items whose Test passes, asking about the ones it cannot evaluate.
---

# Purge Completed Open Items

No argument is declared. Walk every item in `<root>/.OPEN.md`.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- Run `git check-ignore -q .OPEN.md` from `<root>`; if it fails, report that the global ignore rule is missing and stop.
- Read `<root>/.OPEN.md`. If it is absent or has no items, report `Nothing to purge` and stop. An item is a `- [ ] ` or `- [*] ` line; its `Test:` is the next line when it starts with six spaces and `Test:`. Skip every other line.

## Walk

For each item in file order:

- **Test passes.** Remove the description and Test lines, clear `[*]` if it was focused, write the file, report the removal, and continue.
- **Test fails.** Keep the item, report the failure and the evidence, and continue.
- **Test cannot be evaluated.** Search the commit history for why the target disappeared or changed: `git log --all --oneline -- <path>`, `git log -S<symbol>`, and `git log -G<pattern>`, reading full messages. Present the explanation with the commit hash and subject. Ask the user to confirm deletion. Remove only on confirmation; otherwise keep the item and continue.
- **No `Test:` line.** Report the malformed item and leave it untouched.

Use the repository, its history, and the session context as evidence. Use only read-only checks; never change the repository to make a Test pass. Do not delete an item because a Test is merely inconvenient or because the target moved without evidence.

## Report

After the last item, report:

- removed because the Test passed,
- removed after confirmation,
- kept because the Test failed,
- kept because the Test could not be evaluated or the user declined,
- malformed items left untouched,
- the remaining item count and focus state.

Do not stage or commit. State that nothing was staged or committed.

## Idempotency

Every removal has the precondition that its item exists and passes or is confirmed. After the removal, the item is gone, so a second run cannot remove it again. A second run reports `Nothing to purge` when no passing or confirmable items remain.
