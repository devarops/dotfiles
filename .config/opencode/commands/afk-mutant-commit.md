---
description: Re-validate the uncommitted mutation-killing test and commit it.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now committing the test that kills a surviving mutant.

The kill prompt left one new test under `tests/` and no other change. This command re-validates the test, commits it once the suite passes, and leaves the next mutation run to the harness.

## Task

- Verify that the working tree has uncommitted changes only under `tests/`, which includes fixtures under `tests/data/`.
- If no test changed, output <error>FAIL: no test to commit</error> and stop.
- If a path outside `tests/` changed or is staged, output <error>FAIL: unexpected changes outside tests</error> and stop.
- Read `git log --patch --max-count 8` and read the full commit messages and diffs. They carry the lessons and the mutation history of the session.
- Read the uncommitted diff and the production code it exercises. The test names the behavior that the mutation breaks; do not run the mutation suite.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests`.
- Confirm that every unit test passes. If any fails, output <error>FAIL: failing unit tests detected</error> and stop. Do not commit.
- Stage only the test and its fixtures.
- Commit them with the message below.
- Report the commit hash and the command that undoes the commit. Stop. Do not proceed to another hunt.

## Format

- First line: `👾🏹 Kill mutant that [describe the mutation]`
  - Keep the line under 72 characters.
  - Example: `👾🏹 Kill mutant that breaks past the slot count`
- Second line: blank.
- Remaining paragraphs, each separated by a blank line:
  1. Explain why the mutant survived: the gap in the suite that let the change pass.
  2. Explain what the test does now to catch it.
  3. State what this test leaves uncovered, or what the next hunt should take.
- Do not name an acceptance criterion, add a `Screens and states:` paragraph, or use a Conventional Commit prefix.
- Do not amend, push, or stage unrelated files.
