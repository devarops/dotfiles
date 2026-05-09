---
name: fail
description: Run the test suite during the Red TDD phase, verify one and only one test fails for the right reason, and commit if so.
---

## Task

1. Run the test suite: `docker exec <container_name> make test`
2. Verify that exactly one test is failing.
   - If no tests fail, inform the user and stop. Do not commit.
   - If more than one test fails, inform the user and stop. Do not commit.
3. Verify that the single failing test fails for the right reason. Confirm the failure aligns with the expected behavioral gap identified in the Red phase.
   - If the test fails for an unexpected or unrelated reason, inform the user and stop. Do not commit.
4. If exactly one test fails for the right reason, commit the failing test with a message that clearly describes the expected behavior.
5. Stop after the commit. Do not proceed to the next Green or Refactor TDD phase.

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
- Show the result of `git diff HEAD~1` so the user can review the committed changes.
- Offer the user the option to undo the last commit.
