---
description: Evaluate the acceptance specs, report a failing criterion, and activate one skipped criterion.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the acceptance phase of the ATDD outer loop.

The command evaluates the acceptance specs, hands a failing criterion to the harness, activates one skipped criterion, and stops when the specs are complete. In a repository with a printer, it also gates the acceptance boundary on the visual baseline. The harness routes to `atdd-red`, the inner loop, or `ui-approve`. You are an adversarial reviewer: your report is independent, objective, and concise.

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

### Print prerequisite

Applies only when `tests/printer/print.py` exists; otherwise skip it and continue to Complete
or Activation. Run it only when every active criterion passes; a failing criterion owns the
handoff above.

- Run `docker exec ${PWD##*/}_dev make print`. If the target is missing, the container is
  missing, or the print fails, output <error>FAIL: print check failed</error> and stop.
- For each file in `tests/printer/received/`, compare it by content with the file of the same
  name in `tests/printer/approved/`. Mark it `same`, `changed`, or `new`. List every
  `approved/` file with no received counterpart as an orphan.
- If every pair is `same` and there is no orphan, continue to Complete or Activation.
- If any pair is `changed` or `new`, or there is an orphan, report each scenario name and its
  status, report the handoff `visual change pending approval; run ui-approve`, and stop. Do
  not remove a `skip`, do not emit <promise>COMPLETE</promise>, and do not write `approved/`
  or `review.html`.
- The handoff is a report, not a request for input. Do not ask the user; the harness routes.
- A second run after `ui-approve` finds every pair `same` and continues.

### Complete

- If every active criterion passes, the print prerequisite passes or does not apply, and no
  criterion in any spec is skipped, output <promise>COMPLETE</promise> and stop.

### Activation

- If every active criterion passes, the print prerequisite passes or does not apply, and at
  least one criterion is skipped, select exactly one skipped criterion to activate.
- Choose by dependency and risk, not by position. Prefer a criterion whose prerequisites are already covered by the behavior the active criteria verify. Among those, prefer the smallest new public-interface surface and the lowest risk to active criteria. Use spec-path order, then criterion order, only as a tie-breaker.
- State the rationale for the selection.
- Remove only that criterion's `skip` field from its spec file. Leave every description, verify block, and other field unchanged.
- Leave the edit uncommitted. The harness commits it and routes the next step.
- Do not run `make verify` again, inspect the acceptance test, or decide whether the test exists. The harness owns routing.
- Report the activated criterion, its spec path, and the rationale, then stop.

### Boundaries

- The specs under `specs/` are the source of truth. This command changes only the `skip` field of one criterion.
- Never edit a description or verify block, never mark a criterion passed, never write a result file, and never commit.
- The print prerequisite writes only `tests/printer/received/` through `make print`, which is
  gitignored. It never writes `approved/` or `review.html`; `ui-approve` owns the baseline.
- The only phase failures are misconfiguration: a dirty working tree, no spec or an ambiguous name, a missing verification target, a missing container, unavailable qed, a missing or failing print target in a repository with a printer, or a verification error that names no criterion.

## Format

- For a failing criterion, use the report described above.
- For a print handoff, name each changed, new, or orphan scenario and state `run ui-approve`.
- For an activation, name the activated criterion, its spec path, and the rationale.
