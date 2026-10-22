---
description: Write the next smallest failing test toward the first failing qed criterion.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Red phase of Test-Driven Development (TDD).

The Red phase identifies the behavioral gap between the current system and the first failing criterion of the project's acceptance spec, then specifies a single failing test that represents the smallest possible step toward closing the gap.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Read the full text of the last few commit messages (not just the first line) to understand the lessons, insights, rationale, and recommendations they provide.
- Use the single acceptance spec under `specs/` (`*.spec.toml` or `*.spec.json`). Zero or several: output <error>FAIL: acceptance spec not found or ambiguous</error> and run: exit 1
- Run the project's verify target from the repository root: `make verify`. It calls `qed verify specs`.
- The Gold is the first criterion failing, in file order. If every criterion passes, output <promise>COMPLETE</promise>.
- Read the Gold's description and its `verify` block.
- Analyze the existing test suite to determine the system's current observable behavior.
- Infer the current behavior strictly from the tests, not from assumptions about the implementation.
- Compare the current behavior against the Gold to identify the behavioral gap.
- Run the test suite with `docker exec ${PWD##*/}_ci make tests`. If a test already fails, report it and stop: the red test is already committed and the next move belongs to green.
- Identify the next minimal failing test that represents the smallest possible behavioral increment toward closing that gap.
- Ensure the test does not introduce premature generalization or attempt to reach the Gold in a single step.
- Ensure the test requires the minimal possible production code change to pass.
- Do not write more of a test than is sufficient to fail: one assertion, minimal setup, no extra structure.
- Write exactly one failing unit test.
- Do not write production code.
- Do not edit existing test or production code; only add the new test code.
- Run the test suite with `docker exec ${PWD##*/}_ci make tests`
- Verify that exactly one test is failing.
- Confirm the failure aligns with the expected behavioral gap between the current behavior and the Gold.
- If exactly one test fails for the right reason, commit the failing test with a message that clearly describes the expected behavior.
- If no tests fail, if more than one test fails, or if the failure does not align with reducing the behavioral gap, investigate and resolve the issue before committing.

## Format

- Commit message structure:
  - First line: `🛑 🧪 [brief description of the expected behavior]`
    - Example: `🛑 🧪 Expect support for negative numbers`
  - Second line: blank
  - Remaining lines (each as a separate paragraph):
    - Explain what behavior the failing test specifies.
    - Explain why the test fails under the current implementation.
    - Explain why passing the test does not prematurely reach the Gold.
    - State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
