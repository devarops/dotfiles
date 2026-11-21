---
description: Report the paste-ready qed criterion for a behavioural change, or add the capture scenario for a visual-only change.
---

You are the gate and the visual Red of the UI loop. You never write a `specs/*.spec.toml`
criterion and you never write an acceptance test. The user owns the criterion; `atdd-red`
owns the test.

## Preconditions

- Work from the repository root (`git rev-parse --show-toplevel`).
- `git status --porcelain` must be empty: no staged, modified, deleted, or untracked file.
  If any exists, list it and stop.
- The invocation must name the change and the screens and states it expects to touch. If it
  does not, report that and stop.
- If the development container is missing, report that and stop.
- Read `git log --patch --max-count 8`, every top-level `specs/*.spec.toml`, the existing
  `tests/test_acceptance_*.py`, the styleguide when the repository has one, and `SCENARIOS`
  in `tests/printer/print.py`.
- Run `docker exec ${PWD##*/}_dev make verify`. If an acceptance criterion already fails,
  report that a behavioural Red is pending and stop: `atdd-red` and the inner loop own it.
- Run `docker exec ${PWD##*/}_dev make tests`. If a unit test fails, report it and stop.

## Gate

Decide whether the change can be expressed as a qed criterion. It can when the public
interface can decide the behaviour through an acceptance test: a state, an input, an
output, a transition, or a rule. Appearance alone cannot be a criterion; the approved print
records it.

If it can, report a paste-ready criterion and stop. Write nothing. The report contains:

- the target `specs/*.spec.toml`, matching an existing spec by subject; create a new spec
  only when nothing fits;
- a complete `[[criteria]]` block, with `description` in the spec's prose style and
  `[criteria.verify]` naming the exact command and test node;
- the `tests/test_acceptance_*.py` file and node that `atdd-red` will write, and the
  instruction to add the criterion unskipped;
- the old criterion and its test to retire, when the change supersedes one: the user retires
  the criterion in the same manual edit and `atdd-red` retires the test;
- `Screens and states:` for the Red commit body;
- the instruction to add the criterion manually outside this command and outside the ui
  cycle, and then run `atdd-red`.

If it cannot, the change is visual-only. Continue.

## Visual-only Red

- Add exactly one capture scenario to `tests/printer/print.py`, using the repository's
  scenario shape and a `<screen>--<state>` name. Add a new fixture under `tests/data/` only
  when needed; never modify a fixture that existing tests or scenarios use.
- Add the scenario only when no existing scenario can show the change. If one can, report
  its name and stop without writing; that scenario is the pending failure, and the user runs
  `ui-green` against it.
- If the print artifact cannot show the change, stop and report that limitation.
- Do not edit production code, a spec, a test, the styleguide, or `approved/`.
- Run `docker exec ${PWD##*/}_dev make verify` and `make tests`; every test must pass.
- Run `docker exec ${PWD##*/}_dev make print`; confirm the new scenario produced a received
  artifact and was not skipped by a `requires` marker. If it was skipped or absent, report
  the limitation and stop. The visual diff is the pending failure; do not wait for it here.
- Stage only the scenario, a new fixture, and the repository's render-contract test when one
  exists.
- Commit with `🛑🧪 <brief expected behaviour>` on the first line, a blank second line, and
  body paragraphs:
  1. `Screens and states:` the requested change and the screens and states it touches.
  2. The scenario and why the acceptance suite stays green: the visual diff is the pending
     failure.
  3. The spec rule or gap; appearance alone is recorded by the approved print.
- Report the commit hash and `git revert <hash>`. Stop.

## Rules

- Never write a criterion, an acceptance test, or production code.
- Never modify `approved/`.
- Never stage `tests/printer/received/` or `tests/printer/review.html`.
- Never invent a scenario that the change does not show.
- A second run after the visual Red finds the scenario already in `print.py` and the tree
  clean; report that the visual Red already exists and stop without writing.
