---
description: Implement the visual-only change, verify the capture scenario now differs from the approved baseline, and commit the production code.
---

We are now in the Green phase of the visual-only UI loop.

Green turns the capture-scenario Red committed by `ui-red` into production code. The named
scenario is the pending failure: after the change, `make print` must produce a received
artifact that differs from the approved one. If it does not, the Green or the Red is wrong.

## Task

- Work from the repository root. Verify that the working tree is clean; if not, list it and
  stop.
- Read the full text of the last few commit messages, especially the Red commit's
  `Screens and states:` paragraph. When `ui-red` reported an existing scenario and there is
  no Red commit, the invocation names that scenario; treat it as the pending failure.
- If the development container is missing, report that and stop.
- Run `docker exec ${PWD##*/}_dev make verify` and `make tests`; every test must pass. If one
  fails, report it and stop: a visual-only Red leaves both suites green.
- Change only production files. Do not edit tests, `tests/printer/print.py`, fixtures,
  specs, the styleguide, or `approved/`.
- Prefer the smallest change that produces the named scenario's visual change. Do not
  refactor, optimize, or improve structure beyond what the change needs.
- Run `make verify` and `make tests` again; every test must pass.
- Run `docker exec ${PWD##*/}_dev make print`.
- For every scenario named by the Red commit or the invocation, compare
  `tests/printer/received/` with `tests/printer/approved/` by content. Require `new` or
  `changed`.
  - If a named scenario is `same`, absent, or skipped, stop without committing. Report that
    no visual change was produced and name the two possible causes: this command did not
    change the screen, or `ui-red`'s scenario cannot show the change. Leave the production
    changes in place for inspection.
  - If any scenario not named by the Red commit or the invocation is `changed`, `new`, or
    approved without a received counterpart, stop without committing and report the
    unexpected scenarios. Leave the production changes in place for inspection.
- When every check passes, commit only the production files. The `received/` diff stays
  uncommitted for `ui-approve`.
- Report the commit hash and `git revert <hash>`. Hand off to `ui-approve`; stop.

## Format

- First line: `✅🧪 <brief imperative summary>`
- Second line: blank.
- Body paragraphs:
  1. How the change produces the visual change the named scenario records.
  2. Why the implementation is minimal and does not generalize prematurely.
  3. Confirmation that `make verify` and `make tests` pass, the named scenarios changed, and
     no other scenario changed.
- Do not use Conventional Commit prefixes. Do not amend, push, or stage unrelated files.

## Idempotency

A second run after the Green commit finds the production change committed and the named
scenario still pending approval; it reports that Green is complete and does not commit
again. After `ui-approve`, the baseline matches; a rerun still reports complete from the
commit.
