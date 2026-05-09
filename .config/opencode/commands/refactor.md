---
name: refactor
description: Guide the user to apply small, safe refactorings.
---


We are now in the Refactor phase of Test-Driven Development (TDD).

Your mission is to improve the internal structure of the code without changing its observable behavior.

## Objectives

- Preserve the system’s observable behavior.
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
- Follow the coding style and design principles defined in: https://islas.dev/guia_de_estilo/STYLEGUIDE
- Prefer refactorings that improve alignment with the style guide without changing observable behavior.
- If the style guide conflicts with behavior preservation or test correctness, preserve behavior and passing tests first.

## Task

1. Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
2. If any uncommitted change exists, notify the user and stop immediately.
3. Run the full test suite with `docker exec <container_name> make tests` and confirm that all tests pass.
4. If any test fails, notify the user and stop immediately.
5. Analyze the codebase and identify safe, behavior-preserving refactoring opportunities.
6. Infer refactoring opportunities strictly from the current implementation and tests, not from assumptions about future requirements.
7. Enumerate the candidate refactorings before making any changes.
8. Name each refactoring using [Martin Fowler’s Refactoring Catalog](https://refactoring.com/catalog/?utm_source=chatgpt.com).
9. For each candidate refactoring:
   - explain the rationale,
   - explain how it improves the code,
   - explain how behavior is preserved,
   - and explain the trade-offs, risks, or limitations.
10. Do not apply any refactoring until the user explicitly approves it.
11. After user approval, apply only the selected refactoring, one refactoring at a time.
12. Keep each refactoring step as small and incremental as possible.
13. Run the full test suite after each refactoring step.
14. If any test fails after a refactoring step, undo the changes immediately. Do not introduce additional changes to fix the failed refactoring.
15. When all tests pass, show the resulting changes using `git diff`.
16. Do not stage or commit the changes.
17. Ask the user whether to commit the refactoring changes.

## Format

- Keep all reasoning behavior-focused and refactoring-focused.
- Do not propose feature additions or behavioral changes.
- Do not propose speculative abstractions or future-oriented designs.
- Present candidate refactorings as an enumerated list.
- For each refactoring, include:
  - the refactoring name,
  - the motivation,
  - the expected improvement,
  - and the associated trade-offs or risks.
- After applying approved refactorings:
  - confirm that all tests pass,
  - show the resulting `git diff`,
  - and ask whether to commit the changes.
