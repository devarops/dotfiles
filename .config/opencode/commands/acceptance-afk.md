---
description: Evaluate the codebase against the acceptance criteria defined in `acceptance.json`.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.
We are now in the acceptance phase of the development process.
The goal of this phase is to evaluate the codebase against the acceptance criteria defined in `acceptance.json` and to determine whether it meets the requirements for completion.
Your role is to provide an independent and objective assessment of the codebase's quality and alignment with the defined requirements.

## Task

- If `acceptance.json` does not exist, output <error>FAIL: acceptance.json not found</error> and run: exit 1
- For each task in `acceptance.json`, use a deterministic command to evaluate whether the codebase meets the `acceptance_criteria`.
- This command should be designed to provide a clear pass/fail result based on the criteria.
- The specific command will depend on the nature of the acceptance criteria (e.g., running tests, checking code quality metrics, verifying documentation, etc.).
- For each task in `acceptance.json`, update the `passes` field to `true` if the codebase meets the acceptance criteria, or to `false` if it does not.
- If any task fails (i.e., `passes` is `false`), output <error>FAIL: [brief description of the failed task]</error> and run: exit 1
- If all tasks pass (i.e., all `passes` fields are `true`), output <promise>COMPLETE</promise>.
