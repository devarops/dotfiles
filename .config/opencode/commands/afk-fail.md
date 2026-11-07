---
name: fail
description: Run the unit test suite during the Red TDD phase, verify one and only one unit test fails for the right reason, and commit if so.
---

## Task

1. Run the unit test suite: `docker exec <container_name> make tests`
2. Verify that exactly one unit test is failing, and that the uncommitted changes are what make it fail. Everything else is committed, so committing those changes is what this command does.
   - If no unit tests fail, inform the user and stop. Do not commit.
   - If more than one unit test fails, inform the user and stop. Do not commit.
3. Verify that the single failing unit test fails for the right reason. Confirm the failure aligns with the expected behavioral gap identified in the Red phase.
   - If the unit test fails for an unexpected or unrelated reason, inform the user and stop. Do not commit.
4. If exactly one unit test fails for the right reason, commit the uncommitted changes, which hold the failing unit test, with a message that clearly describes the expected behavior.
5. Show the result of `git diff HEAD~1` so the user can review the committed changes.
6. Offer the user the option to undo the last commit.
7. Stop. Do not proceed to the next Green or Refactor TDD phase.

## Format

- Commit message structure:
  - First line: `🛑 🧪 [brief description of the expected behavior]`
    - Example: `🛑 🧪 Expect support for negative numbers`
  - Second line: blank
  - Remaining lines:
    - explain what behavior the failing unit test specifies,
    - confirm that the unit test fails for the expected reason,
    - and confirm that no other unit tests are broken.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
