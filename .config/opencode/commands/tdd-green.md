---
name: tdd-green
description: Produce the smallest possible production code required to make the current failing unit test pass.
---

We are now in the Green phase of Test-Driven Development (TDD).

Your mission is to produce the smallest possible production code change required to make the current failing unit test pass.


## Task

1. Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
2. If any uncommitted change exists, notify the user and stop immediately.
3. Run the unit test suite with `docker exec <container_name> make tests` and confirm that exactly one unit test is failing.
4. If more than one unit test fails, notify the user and stop immediately.
5. If no unit tests fail, notify the user and stop immediately.
6. Analyze the failing unit test to identify the exact behavioral requirement.
7. Infer the requirement strictly from the failing unit test, not from assumptions about future behavior.
8. Implement only what is necessary to make the failing unit test pass.
9. Avoid adding functionality not required by the unit test.
10. Do not modify or reinterpret the unit test.
11. Prefer the simplest possible solution, including naive implementations, if they satisfy the unit test.
12. Generalize only if a naive implementation causes previously passing unit tests to fail.
13. Do not refactor, optimize, or improve structure beyond what is required for the unit test to pass.
14. Verify that the full unit test suite passes after the implementation.
15. Do not commit unless all unit tests pass.
16. Commit the changes once all unit tests pass.
17. Stop after the commit. Do not proceed to the next Red or Refactor phase.

## Format

- Keep the implementation minimal, direct, and behavior-focused.
- Commit message structure:
  - First line: `✅ 🧪 [brief imperative summary]`
    - Example: `✅ 🧪 Add support for empty input`
  - Second line: blank
  - Remaining lines:
    - explain how the change satisfies the failing unit test,
    - and explain why the implementation is intentionally minimal and does not introduce premature generalization.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
- Show the result of `git diff HEAD~1` so the user can review the committed changes.
- Offer the user the option to undo the last commit.
