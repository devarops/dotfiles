---
description: Write the next smallest failing test toward "The Gold".
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Red phase of Test-Driven Development (TDD).

The Red phase identifies the behavioral gap between the current system and the `acceptance_criteria` defined in the current gold task, then specifies a single failing test that represents the smallest possible step toward closing the gap.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Read the full text of the last few commit messages (not just the first line) to understand the lessons, insights, rationale, and recommendations they provide.
- Search for the current gold task (`"gold": "current"`) in `acceptance.json`.
- If `acceptance.json` does not exist, output <error>FAIL: acceptance.json not found</error> and run: exit 1
- Do not edit `acceptance.json`.
- If the current gold task (`"gold": "current"`) is not explicitly defined in `acceptance.json`, output <error>FAIL: The Gold not defined in acceptance.json</error> and run: exit 1
- Analyze the existing test suite to determine the system's current observable behavior.
- Infer the current behavior strictly from the tests, not from assumptions about the implementation.
- Compare the current behavior against the `acceptance_criteria` to identify the behavioral gap.
- Identify the next minimal failing test that represents the smallest possible behavioral increment toward reducing that gap.
- Ensure the test does not introduce premature generalization or attempt to reach `acceptance_criteria` in a single step.
- Ensure the test requires the minimal possible production code change to pass.
- Do not write more of a test than is sufficient to fail: one assertion, minimal setup, no extra structure.
- Write exactly one failing unit test.
- Do not write production code.
- Do not edit existing test or production code; only add the new test code.
- Run the test suite: `docker exec ${PWD##*/}_ci make tests`
- Verify that exactly one test is failing.
- Confirm the failure aligns with the expected behavioral gap between the current behavior and the `acceptance_criteria`.
- If exactly one test fails for the right reason, commit the failing test with a message that clearly describes the expected behavior.
- If no tests fail, if more than one test fails, or if the failure does not align with reducing the behavioral gap, investigate and resolve the issue before committing.

## Format

- Commit message structure:
  - First line: `🛑 🧪 [brief description of the expected behavior]`
    - Example: `🛑 🧪 Expect support for negative numbers`
  - Second line: blank
  - Remaining lines:
    - Explain what behavior the failing test specifies.
    - Explain why the test fails under the current implementation.
    - Explain why passing the test does not prematurely reach `acceptance_criteria`.
    - State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
