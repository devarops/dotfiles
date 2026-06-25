---
name: red
description: Identify the next smallest failing test that incrementally advances the system toward "The Gold".
---

We are now in the Red phase of Test-Driven Development (TDD).

Your mission is to identify the next smallest failing test that incrementally advances the system toward the target behavior "The Gold".

## Task

1. Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
2. If any uncommitted change exists, notify the user and stop immediately.
3. Search for "The Gold" in `TODO.md`.
4. If "The Gold" is not explicitly defined, run: `docker exec <container_name> make verify` and use the first failing criterion as the definition of "The Gold".
6. Analyze the existing test suite to determine the system's current observable behavior.
7. Infer the current behavior strictly from the tests, not from assumptions about the implementation.
8. Compare the current behavior against "The Gold" to identify the behavioral gap.
9. Identify the next minimal failing test that represents the smallest possible behavioral increment toward reducing that gap.
10. Formulate exactly one failing unit test in plain English, not code.
11. Ensure the test does not introduce premature generalization or attempt to reach "The Gold" in a single step.
12. Ensure the test requires the minimal possible production code change to pass.

## Format

* Show "The Gold".
* Provide exactly one failing test description in plain English, not code.
* Include:
  * the scenario or input,
  * the expected outcome,
  * and the reason the test fails under the current implementation.
* Briefly explain why passing the test does not prematurely reach "The Gold".
* Do not provide test code.
* Do not provide production code or implementation hints.
* Do not suggest multiple tests or alternatives.
* Do not edit existing test or production code.
* Keep the language precise, minimal, and behavior-focused.
