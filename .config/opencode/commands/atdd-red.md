---
description: Write the acceptance test for the first failing criterion whose test is missing.
---

This command runs non-interactively. Do not request user input.

We are in the acceptance-test Red phase of the ATDD outer loop. Write the missing acceptance test through the declared public interface.

## Task

- Verify a clean working tree: no staged, modified, deleted, or untracked files.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Read every top-level `specs/*.spec.toml`; do not recurse. Zero specs, or duplicate `name` fields: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- Read the root `AGENTS.md` and require exactly one public interface from its `Public Interface` section. If none or several are primary, output <error>FAIL: public interface not found or ambiguous</error> and stop.
- Run `docker exec ${PWD##*/}_dev make verify` from the repository root. If the container is missing, output <error>FAIL: development container not found</error> and stop. If qed is unavailable, output <error>FAIL: qed not available</error> and stop.
- If no unskipped criterion fails, report that and stop without <promise>COMPLETE</promise>; acceptance owns completion.
- Resolve the failing criterion's spec by qed's name; an unknown name: output the same error and stop. Select the first failing unskipped criterion in spec-path order, then criterion order.
- If that criterion's referenced acceptance test already exists, output <error>FAIL: acceptance test already exists</error> and stop. Do not rewrite, duplicate, or delete the referenced test.
- Read the failing criterion's description and verify block.
- When the criterion supersedes a behaviour, retire the old acceptance test: delete it when
  its criterion is gone, or delete only the contradicting assertion so it passes. Never
  rewrite it to the new expectation; the new test carries it. The manual edit retires the old
  criterion.
- Read the full text of the last few commit messages for their lessons and rationale.
- Read the existing tests for conventions and current behavior, not production code.

### Public interface and runner

- Use only black-box sources: `AGENTS.md`, the spec, README or public docs, and existing tests. If they do not identify the interface calls, inputs, and payloads, output <error>FAIL: public interface details not found</error> and stop.
- Infer the runner from the criterion's verify command. Support pytest, R testthat through `Rscript`, and ShellSpec. Any other runner: output <error>FAIL: unsupported acceptance runner</error> and stop.
- Choose the public-interface client from the declared interface and existing test conventions. Use `TestClient` for FastAPI, `CliRunner` for Typer, testthat for an R interface, or ShellSpec for a shell CLI. If no supported client applies, output <error>FAIL: unsupported public interface</error> and stop.

### Test location

- For pytest, use the exact file and test node named in the verify command. Create the file if needed; append the node if the file already exists.
- For R testthat or ShellSpec, the verify command names a file. Derive the group name from the criterion's first sentence, normalized to one line, and use a generic case named `satisfies the criterion`.
- A pytest test exists when its file and node exist; a file-level test exists when its group name appears.
- Add only the new test case and its imports or helpers, except the retirement above.

### Test content

- Write the complete acceptance test for the criterion, covering the whole scenario, not a unit step.
- Use relational assertions derived from the scenario prose when exact values are absent. Assert observable states such as equality, inequality, presence, and status.
- Test only through the declared public interface; never import internal modules or call private helpers.
- Create the dedicated fixture CSV under `tests/data/` named `acceptance_<feature>_<criterion_slug>.csv` when needed. Use the spec name and criterion slug.
- Do not write production code. Do not edit the spec, including its `skip` field. The criterion must already be unskipped.

### Validation

- Before writing, `make verify` fails because the test is missing. After writing, a Red must fail inside the test body.
- Run the criterion's exact acceptance test.
- If it passes, run `make tests` and `make verify`; commit Green only when neither reports a failure.
- A failing test is a valid Red when the failure is an assertion or an interface-absence error inside the test body, such as a missing key, missing attribute, 404, unknown CLI command, or nonzero CLI exit.
- A collection, import, or syntax error is not a valid Red. Output <error>FAIL: acceptance test does not run</error> and stop.
- For a file-level runner, confirm the failure belongs to the new group. A failure in an existing group is not a valid Red.
- After a valid Red, `make tests` must report no failure and `make verify` exactly one failing acceptance test, the new one. Commit Red only then.
- If `make tests` reports any failure, output <error>FAIL: unit tests failed</error> and stop.
- If `make verify` shows any other result, output <error>FAIL: unexpected acceptance result</error> and stop.
- Do not investigate, repair, or commit after an error. Leave the generated files in place for inspection.

### Commit

- Commit the acceptance test, its fixture, and any retired test together; stage only those files.
- Use `🛑🧪 [brief expected behavior]` for a Red commit.
- Use `✅🧪 [brief behavior]` for a Green commit.
- Write the body as separate paragraphs:
  - `Screens and states:` the screens and states it touches, or `none` without a printer or UI surface.
  - Name the scenario and the public interface.
  - Explain why the test fails under the current system, or why it passes without a production change.
  - Name the retired test and why, when one was retired.
  - Explain why this is an outer-loop acceptance test rather than a unit step.
  - State the single most important lesson not already in the last few commit messages.
- Do not use Conventional Commit prefixes.
- Do not amend, push, or stage unrelated files.
- Report the criterion, test path, commit hash, and whether the commit is Red or Green.
