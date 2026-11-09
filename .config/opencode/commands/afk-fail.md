---
description: Re-validate the uncommitted failing unit test and commit it.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the Fail sub-phase of the Red phase of Test-Driven Development (TDD).

The command re-validates the uncommitted failing unit test that `afk-red` left behind. It runs the acceptance and unit suites, applies the same four rules as `afk-red`, and commits the test only when it is the right next step.

## Task

- Read `git log --patch --max-count 8` and read the full commit messages and diffs. The messages carry the lessons, rationale, and the ATDD position of the session.
- Read every top-level `specs/*.spec.toml`; do not recurse. Zero specs, or duplicate `name` fields: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- If the development container is missing, output <error>FAIL: development container not found</error> and stop. If qed is unavailable, output <error>FAIL: qed not available</error> and stop.
- Run `docker exec ${PWD##*/}_dev make verify` from the repository root. If every criterion passes, output <error>FAIL: acceptance criterion already passes</error> and stop. Do not commit.
- If `make verify` fails without naming a criterion, output <error>FAIL: verification failed</error> and stop.
- Qed names the failed spec. Resolve it to its file by the `name` field; an unknown name: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- Select the first failing unskipped criterion in spec-path order, then criterion order.
- If more than one unskipped criterion fails, output <error>FAIL: multiple failing acceptance criteria detected</error> and stop.
- Read its description and `verify` block.
- Run the unit test suite with `docker exec ${PWD##*/}_dev make tests`.
- Confirm that exactly one unit test fails.
- Confirm that the uncommitted changes are only the new test code and its fixtures; everything else is committed. If not, output <error>FAIL: unexpected uncommitted changes</error> and stop.
- Confirm that the failure is an assertion or interface-absence error inside the test body, such as a missing key, missing attribute, 404, unknown CLI command, or nonzero CLI exit.
- A collection, import, or syntax error is not a valid Red. Output <error>FAIL: test does not run</error> and stop.
- Confirm that the failure aligns with the selected acceptance criterion.
- Read the Thorns around the Gold rule at https://blog.cleancoder.com/uncle-bob/2014/11/19/GoingForTheGold.html before choosing or approving a test. Use its definitions of exceptional, degenerate, and ancillary behaviors, in that order, before the core. Repeat across Red cycles until the suite covers them.
- Confirm that the test does not prematurely close the acceptance criterion and requires the smallest possible production change.
- If no unit test fails, if more than one unit test fails, if the failure is not the right reason, if the test grabs the core before the thorns, or if the test needs more than the smallest production change, output <error>FAIL: [the condition]</error> and stop. Do not commit.
- Stage only the test files and their fixtures. Commit them with the message below.
- Report the commit hash and the command that undoes the commit. Stop. Do not proceed to Green or Refactor.

## Format

- Commit message structure:
  - First line: `🛑 🧪 [brief description of the expected behavior]`
    - Example: `🛑 🧪 Expect support for negative numbers`
  - Second line: blank
  - Remaining paragraphs, each separated by a blank line:
    1. Name the acceptance criterion: the spec path, the first sentence of its description, and its verify command.
    2. Explain what behavior the failing unit test specifies.
    3. Explain why the test fails under the current implementation.
    4. Explain which exceptional, degenerate, and ancillary behaviors the test covers and which it leaves uncovered, and why passing it does not prematurely close the criterion.
    5. Confirm that no other unit test fails.
    6. State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
- Do not amend, push, or stage unrelated files.
