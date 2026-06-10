---
description: Write the next smallest failing test toward "The Gold".
---

We are now in the Red phase of Test-Driven Development (TDD).

The Red phase identifies the behavioral gap between the current system and "The Gold", then specifies a single failing test that represents the smallest possible step towards closing the gap.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, notify the user and stop immediately.
- Search for "The Gold" (`"gold": "current"`) in `prd.json`.
- If "The Gold" is not explicitly defined, prioritize one of the tasks in `prd.json` (not necessarily the first task) and mark it as the current gold (update to `"gold": "current"`).
- If `prd.json` does not exist, notify the user and stop immediately.
- Analyze the existing test suite to determine the system's current observable behavior.
- Infer the current behavior strictly from the tests, not from assumptions about the implementation.
- Compare the current behavior against "The Gold" to identify the behavioral gap.
- Identify the next minimal failing test that represents the smallest possible behavioral increment toward reducing that gap.
- Ensure the test does not introduce premature generalization or attempt to reach "The Gold" in a single step.
- Ensure the test requires the minimal possible production code change to pass.
- Do not write more of a test than is sufficient to fail: one assertion, minimal setup, no extra structure.
- Write exactly one failing unit test.
- Include:
  - the scenario or input,
  - the expected outcome,
- Show "The Gold".
- Briefly explain the reason the test fails under the current implementation.
- Briefly explain why passing the test does not prematurely reach "The Gold".
- Do not provide production code or implementation hints.
- Do not suggest multiple tests or alternatives.
- Do not edit existing test or production code, only add the new test code.
