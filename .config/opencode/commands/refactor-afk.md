---
description: Apply small, safe refactorings.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Refactor phase of Test-Driven Development (TDD).

The Refactor phase improves the internal structure of the code without changing its observable behavior.

## Task

- Preserve the system's observable behavior.
- Do not introduce new features, logic, or test cases.
- Apply only small, incremental, behavior-preserving refactorings.
- Improve readability and clarity.
- Improve naming to better express intent and domain meaning.
- Ensure names within the same scope use a consistent level of abstraction and domain vocabulary.
- Simplify unnecessarily complex or redundant structures.
- Prefer clarity over reducing line count.
- Improve the internal design and maintainability of the code.
- Remove duplication where safely possible.
- Reduce accidental complexity.
- Avoid speculative generalization, over-engineering, or architectural expansion.
- Refactor only in response to the current code structure and observable behavior, not anticipated future requirements.
- Follow the architectural principles defined in: https://islas.dev/2026/05/15/arquitectura
- Follow the coding style defined in: https://islas.dev/guia_de_estilo/STYLEGUIDE
- Follow the design patterns defined in: https://islas.dev/2026/03/20/desacoplamiento
- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Run the full test suite with `docker exec ${PWD##*/}_ci make tests` and confirm that all tests pass.
- If any test fails, output <error>FAIL: failing tests detected</error> and run: exit 1
- Analyze the codebase and identify safe, behavior-preserving refactoring opportunities.
- Infer refactoring opportunities strictly from the current implementation and tests, not from assumptions about future requirements.
- Use the catalog of refactorings defined in https://refactoring.com/catalog/
- For each refactoring, think about:
   - the rationale,
   - how it improves the code,
   - how behavior is preserved,
   - and the trade-offs, risks, or limitations.
- Prioritize refactorings that improve readability, clarity, and maintainability over those that reduce line count or add abstraction.
- Prioritize refactorings that offer a clear and immediate improvement with lower risk.
- Apply only one single refactoring, even if multiple opportunities are identified.
- Run the full test suite after applying the refactoring to verify that all tests still pass and that no behavior has changed.
- If any test fails after a refactoring, undo the changes immediately with `git restore .`; do not introduce additional changes to fix the failed refactoring.
- When all tests pass, commit the refactoring changes.

## Format

- Commit message structure:
  - First line: `♻ 🧪 [name from https://refactoring.com/catalog/]`
    - Example: `♻ 🧪 Rename variable`
  - Second line: blank
  - Remaining lines:
    - explain the rationale for the refactoring,
    - how it improves the code,
    - how it preserves behavior,
    - and any trade-offs, risks, or limitations.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
