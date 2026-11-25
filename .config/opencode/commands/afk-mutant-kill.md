---
description: Kill one surviving mutant with a new test and leave it uncommitted.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the mutation hunting phase of Test-Driven Development (TDD).

The green commit passed the suite, but mutation testing found changes to the production code that no test detects. This command runs the mutation suite, selects one survivor, writes one test that kills it, and leaves the test uncommitted for `afk-mutant-commit`.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Read `git log --patch --max-count 8` and read the full commit messages and diffs. They carry the lessons and the mutation history of the session.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests` and confirm that it passes.
- If any unit test fails, output <error>FAIL: failing unit tests detected</error> and stop.
- Run `docker exec ${PWD##*/}_dev make mutants` from the repository root. The target exits zero only when no mutant survives.
- If the command cannot run, output <error>FAIL: mutation run failed</error> and stop.
- If it exits zero, output <error>FAIL: no surviving mutants</error> and stop. The caller invoked this command because survivors remained.
- Read the survivors the run reports and select one. Prefer a survivor whose behavior a test can observe simply.
- Read the production code the selected mutant changes and the tests around it.
- Write exactly one new test that fails when the mutant is present and passes on the current code.
- Name the test after the behavior the mutation breaks.
- Do not modify production code or existing tests; only add the test and its fixtures under `tests/`.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests`.
- Confirm that the new test passes and that no other test fails.
- Do not run the mutation suite again. The harness repeats it after `afk-mutant-commit`.
- Leave the test and its fixtures uncommitted for `afk-mutant-commit`. Do not commit.

## Validation

- The working tree changes only paths under `tests/`, which includes fixtures under `tests/data/`.
- The new test and its fixtures are the only changes; no production file changed.
- `make tests` passes.
- If no test was added, output <error>FAIL: no test added</error> and stop.
- If a test fails, output <error>FAIL: failing unit tests detected</error> and stop.
- If a path outside `tests/` changed, output <error>FAIL: unexpected changes outside tests</error> and stop.

## Report

- Report the survivor selected, the test path, and the behavior the test pins.
- Stop. Do not commit and do not proceed to the commit prompt.
