---
description: Apply one small, safe, behaviour-preserving refactoring.
---

We are now in the Refactor phase of the visual-only UI loop. Run it only after `ui-approve`; the
approved print is the visual contract.

Refactor improves the internal structure of the production code and the acceptance tests without
changing observable behaviour. Apply exactly one refactoring per invocation.

## Task

- Work from the repository root. Verify that the working tree is clean; if not, list it and stop.
- Read the full text of recent commit messages for the lessons, rationale, and recommendations.
- If the development container is missing, report that and stop.
- Run `docker exec ${PWD##*/}_dev make verify`; every test must pass. If any fails, report it and
  stop.
- Identify safe, behaviour-preserving refactoring opportunities in the production code and in
  `tests/test_acceptance_*.py`.
- Use the catalog at https://refactoring.com/catalog/ and the style guide at
  https://islas.dev/guia_de_estilo/.
- Read `~/.config/opencode/quality-practices.md` as an additional quality reference.
- Prioritize readability, naming, duplication, dead code, and clarity over line count.
- Apply only the single most important refactoring. If no safe refactoring remains, report that
  and stop without writing or committing.
- Never touch `tests/printer/print.py`, fixtures, specs, the styleguide, or `approved/`.
- Run `docker exec ${PWD##*/}_dev make verify` after the refactoring. If any test fails, run
  `git restore .` and report it. Do not try to repair the failed refactoring.
- Commit the refactoring with the message below.
- Report the commit hash and `git revert <hash>`. Stop.
- A second run applies the next safe refactoring. When none remains, it reports that and stops
  without writing.

## Format

- First line: `♻️🧪 <name from the refactoring catalog>`
- Second line: blank.
- Body paragraphs:
  1. The rationale and how the refactoring improves the code.
  2. How behaviour is preserved.
  3. Trade-offs, risks, or limitations.
- Do not use Conventional Commit prefixes. Do not amend, push, or stage unrelated files.
