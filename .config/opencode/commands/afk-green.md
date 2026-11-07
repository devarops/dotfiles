---
description: Produce the smallest possible production code to make the current failing test pass.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Green phase of Test-Driven Development (TDD).

The Green phase passes the failing test with the smallest possible production code change, deferring structural improvements to the Refactor phase.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error>.
- Read the full text of the last few commit messages (not just the first line) to understand the lessons, insights, rationale, and recommendations they provide.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests` and confirm that exactly one unit test is failing.
- If more than one unit test fails, output <error>FAIL: multiple failing unit tests detected</error>.
- If no unit tests fail, output <error>FAIL: no failing unit tests detected</error>.
- Analyze the failing test to identify the exact behavioral requirement.
- Infer the requirement strictly from the failing test, not from assumptions about future behavior.
- Implement only what is necessary to make the failing test pass, and nothing more.
- Do not modify or reinterpret the test.
- Prefer the simplest possible solution, including naive implementations, if they satisfy the test.
- Generalize only if a naive implementation causes previously passing tests to fail.
- Do not refactor, optimize, or improve structure beyond what is required for the test to pass.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests` to verify that the full unit test suite passes after the implementation.
- Commit only when all unit tests pass.

## Format

- Commit message structure:
  - First line: `✅ 🧪 [brief imperative summary]`
    - Example: `✅ 🧪 Add support for empty input`
  - Second line: blank
  - Remaining lines (each as a separate paragraph):
    - Explain how the change satisfies the failing test.
    - Explain why the implementation is intentionally minimal and does not introduce premature generalization.
    - State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
