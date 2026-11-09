---
description: Write and validate the next failing unit test toward the failing acceptance criterion.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Red phase of Test-Driven Development (TDD).

The Red phase identifies the behavioral gap between the current system and the failing acceptance criterion, writes one failing unit test, and validates that the test is the right next step. It leaves the test uncommitted for `afk-fail`, which re-validates and commits it.

## Task

- The failing acceptance criterion is the first criterion in the spec, in file order, whose verify command fails, ignoring criteria marked skip.
- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Use the single acceptance spec under `specs/` (`*.spec.toml` or `*.spec.json`). Zero or several: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- Run `docker exec ${PWD##*/}_dev make verify` from the repository root. It calls `qed verify specs`.
- If every criterion passes, output <promise>COMPLETE</promise> and stop.
- Read the failing acceptance criterion's description and its `verify` block.
- Read `git log --patch --max-count 8` and read the full commit messages and diffs. The messages carry the lessons, rationale, and the ATDD position of the session.
- Analyze the existing unit test suite to determine the system's current observable behavior.
- Infer the current behavior strictly from the tests, not from assumptions about the implementation.
- Compare the current behavior against the failing acceptance criterion to identify the behavioral gap.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests`. If a unit test already fails, report it and stop: the red unit test is already committed and the next move belongs to green.
- Read the Thorns around the Gold rule at https://blog.cleancoder.com/uncle-bob/2014/11/19/GoingForTheGold.html before choosing or approving a test. Use its definitions of exceptional, degenerate, and ancillary behaviors, in that order, before the core. Repeat across Red cycles until the suite covers them.
- Identify the next minimal failing test that represents the smallest possible behavioral increment toward closing the gap.
- Ensure the test does not introduce premature generalization or attempt to reach the failing acceptance criterion in a single step.
- Ensure the test requires the minimal possible production code change to pass.
- Do not write more of a test than is sufficient to fail: one assertion, minimal setup, no extra structure.
- Write exactly one failing unit test.
- Do not write production code.
- Do not modify existing test cases or production code; only add the new test code.

### Validation

- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests`.
- Confirm that exactly one unit test fails.
- Confirm that the failure is an assertion or interface-absence error inside the test body, such as a missing key, missing attribute, 404, unknown CLI command, or nonzero CLI exit.
- A collection, import, or syntax error is not a valid Red. Output <error>FAIL: test does not run</error> and stop.
- Confirm that the failure aligns with the expected behavioral gap between the current behavior and the failing acceptance criterion.
- Confirm that the test follows the Thorns around the Gold rule above.
- Confirm that the test does not prematurely close the acceptance criterion and requires the smallest possible production change.
- If no unit test fails, if more than one unit test fails, if the failure is not the right reason, if the test grabs the core before the thorns, or if the test needs more than the smallest production change, output <error>FAIL: [the condition]</error> and stop. Do not investigate, repair, or commit.
- Leave the test and its fixtures uncommitted for `afk-fail`. Do not commit.

## Report

- Report the selected acceptance criterion, the test path, and the expected failure.
- Stop. Do not proceed to Green or Refactor.
