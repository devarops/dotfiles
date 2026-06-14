---
description: Evaluate the codebase against "The Gold" and the acceptance criteria defined in acceptance.json.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

We are now in the gold phase of the development process.

You are an adversarial reviewer responsible for evaluating the codebase against the task description and the `acceptance_criteria` defined in `acceptance.json`.
Your role is to provide an independent and objective assessment of the codebase's alignment with the defined requirements.
You also provide concise, actionable feedback to improve the codebase and meet the acceptance criteria.

## Task

- Verify that the working tree is clean: no staged changes, no modified or deleted tracked files, and no untracked files or directories.
- If any uncommitted changes exist, output <error>FAIL: uncommitted changes detected</error> and run: exit 1
- Read the full text of the last few commit messages (not just the first line) to understand the lessons, insights, rationale, and recommendations they provide.
- If `acceptance.json` does not exist at the root of the repository, output <error>FAIL: acceptance.json not found</error> and run: exit 1
- Search for `"gold": "current"` in `acceptance.json` to find "The Gold."
- If no task is set as `"gold": "current"`, scan the backlog tasks (`"gold": "backlog"`) in `acceptance.json`.
- Identify the next most important task (not necessarily the first) and promote it to current gold by setting `"gold": "current"`.
- Use a deterministic command to evaluate whether the codebase meets the `acceptance_criteria` defined in `acceptance.json`.
- The command must produce a clear pass/fail result based on the criteria.
- Choose the command according to the nature of the criteria (e.g., running tests, checking code quality metrics, verifying documentation).
- Update the `passes` field of the current gold task in `acceptance.json` to `true` if the codebase meets the acceptance criteria, or to `false` if it does not.
- If the codebase meets the acceptance criteria (`"passes": true`), mark the current gold task as done by setting `"gold": "done"` in `acceptance.json`.
- If the current gold task is done (`"passes": true` and `"gold": "done"`), scan the backlog tasks (`"gold": "backlog"`) in `acceptance.json`.
- Identify the next most important task (not necessarily the first) and promote it to current gold by setting `"gold": "current"`.
- If there are no backlog or current gold tasks in `acceptance.json`, verify that all tasks are marked as done (`"gold": "done"`).
- If all tasks are marked as done and all have `passes` set to `true`, output <promise>COMPLETE</promise>.

## Format

- `acceptance.json` may be tracked or untracked by Git. If untracked, you can edit without committing. If tracked, you must commit the changes.
- Leave a clean working tree after making any changes to `acceptance.json`.
- Commit message structure:
  - First line: `📋 🧪 [brief description of the evaluation result]`
    - Example: `📋 🧪 Verify gold task passes all acceptance criteria`
  - Second line: blank
  - Remaining lines (each as a separate paragraph):
    - Explain the evaluation result.
    - Summarize the rationale for the `passes` value (true or false) based on the evaluation of the acceptance criteria.
    - Describe recommendations for improving the codebase.
    - State the single most important lesson or insight from this session that is not present in the last few commit messages.
- Do not use Conventional Commit prefixes such as `feat:`, `fix:`, or `refactor:`.
