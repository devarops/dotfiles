---
description: Apply small, safe refactorings.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Refactor phase of Test-Driven Development (TDD).

The Refactor phase improves the internal structure of the code without changing its observable behavior.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Read the full text of the last few commit messages (not just the first line) to understand the lessons, insights, rationale, and recommendations they provide.
- Run the full test suite with `docker exec ${PWD##*/}_ci make tests` and confirm that all tests pass.
- If any test fails, output <error>FAIL: failing tests detected</error> and run: exit 1
- Analyze the codebase and identify safe, behavior-preserving refactoring opportunities.
- Prioritize refactorings that improve readability, clarity, and maintainability over those that reduce line count.
- Extract duplicated logic into a shared variable, function, or abstraction to eliminate duplication and clarify intent.
- Instead of adding comments, improve naming to better express intent and domain meaning.
- Ensure names within the same scope use a consistent level of abstraction and domain vocabulary.
- Simplify unnecessarily complex or redundant structures.
- Remove dead code, unused variables, or any code not exercised by the tests.
- Use the catalog of refactorings defined in: https://refactoring.com/catalog/
- Follow the architectural principles defined in: https://islas.dev/2026/05/15/arquitectura
- Follow the design patterns defined in: https://islas.dev/2026/03/20/desacoplamiento
- Follow the coding style defined in: https://islas.dev/guia_de_estilo/STYLEGUIDE
- Prioritize refactorings that offer a clear and immediate improvement with lower risk.
- Look for refactoring opportunities in the tests as well as in the production code.
- Apply only the single most important refactoring, even if multiple opportunities are identified.
- Run the full test suite after applying the refactoring to verify that all tests still pass and that no behavior has changed.
- If any test fails after a refactoring, undo the changes immediately by running `git restore .`. Do not introduce additional changes to fix a failing refactoring.
- When all tests pass, commit the refactoring changes.

## Format

- Commit message structure:
  - First line: `♻ 🧪 [name from https://refactoring.com/catalog/]`
    - Example: `♻ 🧪 Rename variable`
  - Second line: blank
  - Remaining lines (each as a separate paragraph):
    - Explain the rationale for the refactoring.
    - Explain how it improves the codebase.
    - Explain how it preserves behavior.
    - Explain any trade-offs, risks, or limitations.
    - State the single most important lesson or insight from this session that is not already present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
