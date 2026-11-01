---
description: Evaluate the codebase against the acceptance criteria its qed spec defines.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.
We are now in the acceptance phase of the development process.
The goal of this phase is to evaluate the codebase against the acceptance criteria its qed spec defines and to determine whether it meets the requirements for completion.
You are an adversarial reviewer responsible for evaluating the codebase against the failing acceptance criterion.
Your role is to provide an independent and objective assessment of the codebase's quality and alignment with the defined requirements.
You also provide concise, actionable feedback to improve the codebase and meet that criterion.
The specs under `specs/` are the source of truth; this command never edits them and never writes a result file.

## Task

- The failing acceptance criterion is the first criterion in the spec, in file order, whose verify command fails, ignoring criteria marked skip.
- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted change exists, output <error>FAIL: uncommitted changes detected</error> and stop.
- Use the single acceptance spec under `specs/` (`*.spec.toml` or `*.spec.json`). Zero or several: output <error>FAIL: acceptance spec not found or ambiguous</error> and stop.
- If `specs/` or the `verify` target is missing, output <error>FAIL: verification not configured</error> and stop.
- If qed cannot run in the project container, output <error>FAIL: qed not available</error> and stop.
- Run `docker exec <container_name> make verify` from the repository root. It calls `qed verify specs` and reports every criterion in `specs/`.
- If every criterion passes, output <promise>COMPLETE</promise> and stop.
- Read the full text of the last few commit messages, not just the first line, for the lessons, rationale, and recommendations they carry.
- If a criterion fails, output <error>FAIL: [the failed criterion qed names]</error> first.
- Then report the failing acceptance criterion: its description, spec path, verify block, and the observed failure.
- Then give concise, actionable feedback to close it.
- State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Write nothing: the spec is the source of truth. Never edit a criterion, never mark it, never commit.
