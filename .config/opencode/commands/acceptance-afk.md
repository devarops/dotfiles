---
description: Evaluate the codebase against the acceptance criteria its qed spec defines.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.
We are now in the acceptance phase of the development process.
The goal of this phase is to evaluate the codebase against the acceptance criteria its qed spec defines and to determine whether it meets the requirements for completion.
Your role is to provide an independent and objective assessment of the codebase's quality and alignment with the defined requirements.
The specs under `specs/` are the source of truth; this command never edits them and never writes a result file.

## Task

- Run the project's verification target from the repository root: `make verify`. It calls `qed verify specs` and reports every criterion in `specs/`.
- If `specs/` or the `verify` target is missing, output <error>FAIL: verification not configured</error> and run: exit 1
- If qed cannot run in the project container, output <error>FAIL: qed not available</error> and run: exit 1
- If the target exits zero, output <promise>COMPLETE</promise>.
- If the target exits non-zero, output <error>FAIL: [the failed criterion qed names]</error> and run: exit 1
