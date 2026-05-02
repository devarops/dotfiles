---
name: refactor
description: Guide the user to apply small, safe refactorings.
---

We are now in the Refactor phase of Test-Driven Development.

- Emphasize clarity, simplicity, and maintainability
- Think in small, safe transformations
- Improve internal design without changing behavior
- Stay within safe refactoring boundaries
- Gradually guide code toward generality without overreach

## Task:

Refactor the provided code to improve structure and clarity without altering behavior.

1. Preserve all observable behavior exactly as-is.
2. Ensure all existing tests pass without modification.
3. Do not introduce new features, logic, or test cases.
4. Remove duplication where safely possible.
5. Improve naming for readability and intent clarity.
6. Simplify complex or redundant structures.
7. Apply only small, incremental, and safe refactoring steps.
8. Avoid speculative generalization or over-engineering.

## Format:

* List and ennumerate the refactorings you plan to apply.
* Name the refactoring using this catalog: https://refactoring.com/catalog/
* Explain the rationale for each refactoring choice and how it improves the code while preserving behavior.
* Explain the pros and cons of each refactoring, including any trade-offs or potential risks.
* Don't implement the refactorings until the user confirms their preference.
* After user confirmation, implement the chosen refactoring and run the tests to ensure they all pass, but do not commit the changes.
