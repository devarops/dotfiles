---
description: Write and validate the failing acceptance test, or the capture scenario, for the requested change.
---

We are now in the Red phase of the UI TDD loop.

The Red turns one requested change into a failing acceptance test, or, when the change has no
observable behaviour, into a capture scenario whose diff is the pending failure. It leaves
production code untouched.

## Task

- Work from the repository root (`git rev-parse --show-toplevel`).
- Verify that the working tree is clean: no staged, modified, deleted, or untracked files. If any
  uncommitted change exists, list it and stop.
- The invocation must name the change and the screens and states it is expected to touch. If it
  does not, report that and stop.
- Read `git log --patch --max-count 8` for the current position, lessons, and rationale.
- Read every top-level `specs/*.spec.toml`, the existing `tests/test_acceptance_*.py` tests, the
  styleguide when the repository has one, and the `SCENARIOS` in `tests/printer/print.py`.
- If the development container is missing, report that and stop.
- Run `docker exec ${PWD##*/}_dev make verify`. If an acceptance test already fails, report it and
  stop: the red test is committed.
- Decide whether the change has observable behaviour:
  - If it does, write exactly one failing acceptance test for the requested behaviour. Put it in
    the matching `tests/test_acceptance_*.py`; if no file matches, use the closest existing file.
    Do not rewrite unrelated cases. When an existing assertion contradicts the requested change,
    update only that assertion. Keep exactly one test failing. Add its criterion to the matching
    `specs/*.spec.toml`, naming the new test node; a criterion without a test is not written here.
  - If it does not, the Red is a capture scenario that shows the change; the acceptance suite
    stays green and the visual diff appears in the next print. Add the scenario only when no
    existing scenario can show the change. If the print artifact cannot show the change, stop and
    report that limitation.
- Add the scenario to `tests/printer/print.py` using the repository's scenario shape and a
  `<screen>--<state>` name. Add a new fixture under `tests/data/` only when needed; never modify a
  fixture that existing tests or scenarios use.
- Do not edit production code, the specs beyond the new criterion, the styleguide, or `approved/`.
- Stage only the test, the criterion, the scenario, a new fixture, and the repository's
  render-contract test when one exists.
- Cover the requested change, not the whole redesign. Do not introduce premature generalization.
- Commit with `🛑🧪 <brief expected behaviour>` on the first line, a blank second line, and body
  paragraphs:
  1. The requested change and the screens and states it is expected to touch, so the scope is on
     record.
  2. The test path and the assertion that fails, or, for a visual-only Red, the scenario and why
     the acceptance suite stays green.
  3. The spec rule or gap the change addresses.
  4. Confirmation that no other acceptance test fails.
- Do not use Conventional Commit prefixes. Do not amend, push, or stage unrelated files.
- Report the commit hash and `git revert <hash>`. Stop.
- A second run after the Red commit finds the committed failing test, reports that the Red commit
  already exists, and stops without writing.
