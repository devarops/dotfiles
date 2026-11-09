---
description: Evaluate the acceptance specs, report a failing criterion, and activate one skipped criterion.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the acceptance phase of the ATDD outer loop.

The command evaluates the acceptance specs, hands a failing criterion to the harness, activates one skipped criterion, and stops when the specs are complete. The harness routes to `atdd-red` or the inner loop. You are an adversarial reviewer: your report is independent, objective, and concise.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Read every top-level `specs/*.spec.toml`; do not recurse. Zero specs, or duplicate `name` fields: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- If `specs/` or the `verify` target is missing, output <error>FAIL: verification not configured</error> and stop.
- If the development container is missing, output <error>FAIL: development container not found</error> and stop.
- If qed cannot run in the project container, output <error>FAIL: qed not available</error> and stop.
- Run `docker exec ${PWD##*/}_dev make verify` from the repository root. It calls `qed verify specs` and reports every criterion in `specs/`.
- Qed names the failed spec. Resolve it to its file by the `name` field; an unknown name: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- If `make verify` fails without naming a criterion, output <error>FAIL: verification failed</error> and stop.
- Read the full text of the last few commit messages, not just the first line, for the lessons, rationale, and recommendations they carry.
- An active criterion is an unskipped criterion.

### Failing criterion

- The failing criterion is the first active criterion in spec-path order, then criterion order, whose verify command fails.
- If an active criterion fails, report its description, spec path, verify block, and observed failure.
- Give concise, actionable feedback to close the gap.
- State the single most important lesson or insight from this session that is not present in the last few commit messages.
- A failing criterion is normal handoff state, not a phase failure. Do not output <error>FAIL</error>; the harness routes on the observed failure.
- Do not edit the spec, the code, or the tests. Stop after the report.

### Complete

- If every active criterion passes and no criterion in any spec is skipped, output <promise>COMPLETE</promise> and stop.

### Activation

- If every active criterion passes and at least one criterion is skipped, select exactly one skipped criterion to activate.
- Choose by dependency and risk, not by position. Prefer a criterion whose prerequisites are already covered by the behavior the active criteria verify. Among those, prefer the smallest new public-interface surface and the lowest risk to active criteria. Use spec-path order, then criterion order, only as a tie-breaker.
- State the rationale for the selection.
- Remove only that criterion's `skip` field from its spec file. Leave every description, verify block, and other field unchanged.
- Leave the edit uncommitted. The harness commits it and routes the next step.
- Do not run `make verify` again, inspect the acceptance test, or decide whether the test exists. The harness owns routing.
- Report the activated criterion, its spec path, and the rationale, then stop.

### Boundaries

- The specs under `specs/` are the source of truth. This command changes only the `skip` field of one criterion.
- Never edit a description or verify block, never mark a criterion passed, never write a result file, and never commit.
- The only phase failures are misconfiguration: a dirty working tree, no spec or an ambiguous name, a missing verification target, a missing container, unavailable qed, or a verification error that names no criterion.

## Format

- For a failing criterion, use the report described above.
- For an activation, name the activated criterion, its spec path, and the rationale.
