---
description: Write the acceptance test for the first failing criterion whose test is missing.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the acceptance-test Red phase of the ATDD outer loop. The command writes the missing acceptance test that observes the system through its declared public interface.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Use the single acceptance spec under `specs/` (`*.spec.toml` or `*.spec.json`). Zero or several: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- Read the target repository's root `AGENTS.md`. Determine its public interface from the `Public Interface` section. Require exactly one declared public interface. If none or several are primary, output <error>FAIL: public interface not found or ambiguous</error> and stop.
- Run `docker exec ${PWD##*/}_dev make verify` from the repository root. If the container is missing, output <error>FAIL: development container not found</error> and stop. If qed is unavailable, output <error>FAIL: qed not available</error> and stop.
- If every unskipped criterion passes, output <promise>COMPLETE</promise> and stop. Skipped criteria do not prevent completion.
- Select the first criterion in file order that is not skipped and whose verify command fails.
- If that criterion's referenced acceptance test already exists, output <error>FAIL: acceptance test already exists</error> and stop. Do not rewrite, duplicate, or delete it.
- Read the failing criterion's description and verify block.
- Read the full text of the last few commit messages, not just the first line, for their lessons, rationale, and recommendations.
- Analyze the existing test suite to learn its conventions and the system's current observable behavior. Do not read production code to derive expected behavior.

### Public interface and runner

- Use only black-box sources: `AGENTS.md`, the spec, README or public docs, and existing tests. If they do not identify the interface calls, inputs, and payloads, output <error>FAIL: public interface details not found</error> and stop.
- Infer the runner from the criterion's verify command. Support pytest, R testthat through `Rscript`, and ShellSpec. Any other runner: output <error>FAIL: unsupported acceptance runner</error> and stop.
- Choose the public-interface client from the declared interface and existing test conventions. Use `TestClient` for FastAPI, `CliRunner` for Typer, testthat for an R interface, or ShellSpec for a shell CLI. If no supported client applies, output <error>FAIL: unsupported public interface</error> and stop.

### Test location

- For pytest, use the exact file and test node named in the verify command. Create the file if needed; append the node if the file already exists.
- For R testthat or ShellSpec, the verify command names a file rather than a node. Derive the group name from the criterion description's first sentence, normalized to one line. Use that name for the `describe` or `Describe` group and a generic case named `satisfies the criterion`.
- Treat a pytest acceptance test as existing when both the file and the named node exist. Treat a file-level acceptance test as existing when the derived group name appears in the file.
- Add only the new test case plus the imports or helpers it needs. Do not modify existing test cases.

### Test content

- Write the complete acceptance test for the criterion. Cover the whole scenario, not a smaller unit step.
- Use relational assertions derived from the scenario prose when exact values are absent. Assert observable states such as equality, inequality, presence, and status.
- Test only through the declared public interface. Do not import internal modules or call private helpers from production code.
- Create one dedicated fixture CSV under `tests/data/` named `acceptance_<feature>_<criterion_slug>.csv` when the scenario needs initial task data. Use the spec name for the feature and the criterion slug for the suffix.
- Do not write production code. Do not edit the spec, including its `skip` field. The criterion must already be unskipped.

### Validation

- Run the criterion's exact acceptance test.
- A passing test is valid. Run the full suite with `docker exec ${PWD##*/}_dev make tests`; commit Green only when everything passes.
- A failing test is a valid Red when the failure is an assertion or an interface-absence error inside the test body, such as a missing key, missing attribute, 404, unknown CLI command, or nonzero CLI exit.
- A collection, import, or syntax error is not a valid Red. Output <error>FAIL: acceptance test does not run</error> and stop.
- For a file-level runner, confirm the failure belongs to the new group. A failure in an existing group is not a valid Red.
- After a valid Red, run the full suite. Commit only when the new acceptance test is the only failure.
- In either outcome, if the full suite has other failures, output <error>FAIL: unexpected test failures</error> and stop.
- Do not investigate, repair, or commit after an error. Leave the generated files in place for inspection.

### Commit

- Commit the acceptance test and its fixture together in one commit. Stage only those files.
- Use `🛑 🧪 [brief expected behavior]` for a Red commit.
- Use `✅ 🧪 [brief behavior]` for a Green commit.
- Write the body as separate paragraphs:
  - Name the scenario and the public interface.
  - Explain why the test fails under the current system, or why it passes without a production change.
  - Explain why this is an outer-loop acceptance test rather than a unit step.
  - State the single most important lesson from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes.
- Do not amend, push, or stage unrelated files.
- Report the criterion, test path, commit hash, and whether the commit is Red or Green.
