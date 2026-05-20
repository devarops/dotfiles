---
description: Update the plan in TODO.md to a TDD cycle format
---

You are updating the plan in TODO.md to follow the Red/Green TDD cycle format.
This command is for planning only; do not implement any code changes.

## Discovery

Explore the target repository:

1. Read `TODO.md` and find the current plan.
2. If `TODO.md` does not exist or does not define a plan, inform the user and stop; otherwise, continue.
3. Read `tests/` to discover test files and infrastructure.
4. Read `git log --oneline -10` for recent context.
5. Read `./*.md` for more context.

## Clarify the Plan

The content of the plan is correct but might lack clarity or not be in the Red/Green TDD cycle format.
Before writing anything, interview the user until reaching shared understanding:

- Ask clarifying questions about the plan and the objective, "The Gold".
- For each question, provide options and indicate your recommendation.
- Ask one question at a time.
- If a question can be answered by exploring the codebase, explore instead of asking.

## Definition of Minimum Semantically Meaningful Change

We define a semantically meaningful change as a change that requires updates to both the test code and the corresponding production code to pass.
We define the minimum semantically meaningful change as the smallest change that satisfies the definition above.
If a change to the production code does not require a change to the tests to pass, it is not a semantically meaningful change.
If a change to the test code does not require a change to the production code to pass, it is not a semantically meaningful change.
All required changes that are not semantically meaningful should be listed in the "Outside the Plan" section instead of the main plan.
If a change can be split into multiple semantically meaningful changes, it should be split into multiple steps in the plan.
Each step in the plan should represent the minimum semantically meaningful change that moves the codebase closer to the final objective, "The Gold".
Since each step represents the minimum semantically meaningful change, the plan is expressed at the finest useful granularity.
However, the plan should not include any steps that are not required to reach "The Gold", nor any steps that are not semantically meaningful changes.
Each step is described as a Red/Green TDD cycle, with the Red phase describing the test code change and the Green phase describing the production code change.

## Edit the Plan

Once the user has confirmed shared understanding:

- Edit `TODO.md` in place.
- Remove completed or obsolete items.
- Convert each remaining task into one or more steps in the Red/Green TDD cycle format.
- Add a "The Gold" section at the top with a one-line statement of the objective.
- Add an "Outside the Plan" section at the end for any non-test changes required to reach the objective.
- Do not add any implementation details to the plan; keep it high-level and focused on behavior.

### Template

```
### The Gold
One-line statement of the objective.

### Plan

1. [Step title]

   **Red:**
   - File: `tests/test_xxx.py`
   - Scenario: [what the test does]
   - Expected: [assertion or expected outcome]
   - Fails because: [reason under current code]

   **Green:**
   - [high-level description of the production code change]

2. [Next step]
   ...

### Outside the Plan

**Final step: [description of non-test changes]**
- Does not follow the Red/Green TDD format — no test evolution required.
```

**Note — Outside the Plan:** All changes that are not semantically meaningful should be listed in this section instead of the main plan.
Omit this section entirely if all required changes are semantically meaningful.

## Constraints

- Red phase must be prescriptive: name the exact file and the exact test behavior.
- Green phase must be high-level: describe intent, not implementation details.
- Do not add steps beyond what is needed to reach The Gold.
- Do not split a single behavioral increment across multiple steps.
- Do not skip required intermediate steps to reach The Gold faster.
- The "Outside the Plan" section must always be last in TODO.md.
- Do not implement anything. This is a planning-only command.
