---
description: Produce the smallest possible production code to make the current failing test pass.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Green phase of Test-Driven Development (TDD).

The Green phase implements the smallest possible production code change required to make the failing test pass, deferring structural improvements to the Refactor phase.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Run the test suite with `docker exec ${PWD##*/}_ci make tests` and confirm that exactly one test is failing.
- If more than one test fails, output <error>FAIL: multiple failing tests detected</error> and run: exit 1
- If no tests fail, output <error>FAIL: no failing tests detected</error> and run: exit 1
- Analyze the failing test to identify the exact behavioral requirement.
- Infer the requirement strictly from the failing test, not from assumptions about future behavior.
- Implement only what is necessary to make the failing test pass, and nothing more.
- Do not modify or reinterpret the test.
- Prefer the simplest possible solution, including naive implementations, if they satisfy the test.
- Generalize only if a naive implementation causes previously passing tests to fail.
- Do not refactor, optimize, or improve structure beyond what is required for the test to pass.
- Run the test suite with `docker exec ${PWD##*/}_ci make tests` to verify that the full test suite passes after the implementation.
- Commit only when all tests pass.

## Format

- Commit message structure:
  - First line: `✅ 🧪 [brief imperative summary]`
    - Example: `✅ 🧪 Add support for empty input`
  - Second line: blank
  - Remaining lines:
    - explain how the change satisfies the failing test,
    - and explain why the implementation is intentionally minimal and does not introduce premature generalization.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
