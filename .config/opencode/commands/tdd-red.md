---
name: tdd-red
description: Identify the next smallest failing test that incrementally advances the system toward the failing acceptance criterion.
---

We are now in the Red phase of Test-Driven Development (TDD).

Your mission is to identify the next smallest failing test that incrementally advances the system toward the failing acceptance criterion.

## Task

- The failing acceptance criterion is the first failing unskipped criterion in spec-path order, then criterion order.
- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, notify the user and stop immediately.
- Read every top-level `specs/*.spec.toml`; do not recurse. If no spec exists, or two specs share a `name` field, report the ambiguity and stop.
- Run `docker exec <container_name> make verify` to find the failing acceptance criterion.
- If no criterion fails, state that no criterion fails and stop. Do not ask, and do not repair anything.
- Qed names the failed spec. Resolve it to its file by the `name` field; an unknown name is ambiguous, so report it and stop.
- Analyze the existing test suite to determine the system's current observable behavior.
- Infer the current behavior strictly from the tests, not from assumptions about the implementation.
- Compare the current behavior against the failing acceptance criterion to identify the behavioral gap.
- Read the Thorns around the Gold rule at https://blog.cleancoder.com/uncle-bob/2014/11/19/GoingForTheGold.html before choosing or approving a test. Use its definitions of exceptional, degenerate, and ancillary behaviors, in that order, before the core. Repeat across Red cycles until the suite covers them.
- Identify the next minimal failing test that represents the smallest possible behavioral increment toward reducing that gap.
- Formulate exactly one failing unit test in plain English, not code.
- Ensure the test does not introduce premature generalization or attempt to reach the failing acceptance criterion in a single step.
- Ensure the test requires the minimal possible production code change to pass.

## Format

* Show the failing acceptance criterion and its spec path.
* Provide exactly one failing test description in plain English, not code.
* Include:
  * the scenario or input,
  * the expected outcome,
  * and the reason the test fails under the current implementation.
* Briefly explain why passing the test does not prematurely reach the failing acceptance criterion.
* Do not provide test code.
* Do not provide production code or implementation hints.
* Do not suggest multiple tests or alternatives.
* Do not edit existing test or production code.
* Keep the language precise, minimal, and behavior-focused.
