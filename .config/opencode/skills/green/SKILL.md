---
name: green
description: Produce the smallest possible amount of production code required to make the current failing test pass.
---

We are now in the Green phase of Test-Driven Development.

Your mission is to produce the smallest possible production code change required to make the current failing test pass.

## Task

1. Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
2. If any uncommitted change exists, notify the user and stop immediately.
3. Run the test suite and confirm that exactly one test is failing.
4. If more than one test fails, notify the user and stop immediately.
5. If no tests fail, notify the user and stop immediately.
6. Analyze the failing test to identify the exact behavioral requirement.
7. Infer the requirement strictly from the failing test, not from assumptions about future behavior.
8. Implement only what is necessary to make the failing test pass.
9. Avoid adding functionality not required by the test.
10. Do not modify or reinterpret the test.
11. Prefer the simplest possible solution, including naive implementations, if they satisfy the test.
12. Generalize only if a naive implementation causes previously passing tests to fail.
13. Do not refactor, optimize, or improve structure beyond what is required for the test to pass.
14. Verify that the full test suite passes after the implementation.
15. Do not commit unless all tests pass.
16. Commit the changes once all tests pass.
17. Stop after the commit. Do not proceed to the next Red or Refactor phase.

## Format

* Keep the implementation minimal, direct, and behavior-focused.
* Use a multi-line commit message with the following structure:
  * First line:
    * `✅ [brief imperative summary]`
    * Example: `✅ Add support for empty input`
  * Second line:
    * blank
  * Remaining lines:
    * explain how the change satisfies the failing test,
    * explain why the implementation is intentionally minimal and it does not introduce premature generalization.
* Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
* Show the result of `git diff HEAD~1` so the user can review the committed changes.
* Offer the user the option to undo the last commit.
