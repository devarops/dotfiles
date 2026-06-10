---
description: Write the next smallest failing test toward "The Gold".
---

We are now in the Red phase of Test-Driven Development (TDD).

The Red phase identifies the behavioral gap between the current system and "The Gold", then specifies a single failing test that represents the smallest possible step towards closing the gap.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Search for "The Gold" (`"gold": "current"`) in `prd.json`.
- If `prd.json` does not exist, <error>FAIL: prd.json not found</error> and run: exit 1.
- Do not edit `prd.json`.
- If "The Gold" is not explicitly defined, output <error>FAIL: The Gold not defined in prd.json</error> and run: exit 1.
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
- Run the test suite: `docker exec ${PWD##*/}_ci make tests`
- Verify that exactly one test is failing.
- Confirm the failure aligns with the expected behavioral gap between the current behavior and "The Gold".
- If exactly one test fails for the right reason, commit the failing test with a message that clearly describes the expected behavior.
- If no tests fail, if more than one test fails, or if the failure does not align with reducing the behavioral gap, investigate and resolve the issue before committing.

## Format

- Commit message structure:
  - First line: `🛑 🧪 [brief description of the expected behavior]`
    - Example: `🛑 🧪 Expect support for negative numbers`
  - Second line: blank
  - Remaining lines:
    - explain what behavior the failing test specifies,
    - confirm that the test fails for the expected reason,
    - and confirm that no other tests are broken.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
