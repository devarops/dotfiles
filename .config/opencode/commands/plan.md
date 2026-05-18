---
description: >
  Create or update the TDD plan in TODO.md.
  Use /plan to read The Gold from TODO.md.
  Use /plan <gold> to set or override The Gold.
---

You are creating or updating the TDD plan in TODO.md.

## Discovery

Explore the target repository:

1. Read `tests/` to discover test files and infrastructure.
2. Read `TODO.md` if it exists.
3. Read key source directories to understand the codebase structure.
4. Read `git log --oneline -10` for recent context.

## Determine The Gold

- If `$ARGUMENTS` is provided, use it as The Gold. Override any existing definition in TODO.md.
- Otherwise, if TODO.md defines "The Gold", keep it.
- Otherwise, stop and ask the user to provide The Gold as an argument.

## Clarify the Plan

Before writing anything, interview the user until reaching shared understanding:

- Ask clarifying questions about the scope, priorities, and boundaries of the plan.
- For each question, provide options and indicate your recommendation.
- Ask one question at a time.
- If a question can be answered by exploring the codebase, explore instead of asking.

## Write the Plan

Once the user has confirmed shared understanding:

If TODO.md exists:
- Edit it in place.
- Remove completed or obsolete items.
- Convert each remaining task into TDD cycle steps.
- Group small related tasks into a single cycle when they belong to the same behavioral increment.

If TODO.md does not exist:
- Create it from scratch with the structure below.

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

### Outside the Plan

Omit this section entirely if there are no non-test changes.

## Constraints

- Red phase must be prescriptive: name the exact file and the exact test behavior.
- Green phase must be high-level: describe intent, not implementation details.
- Do not add steps beyond what is needed to reach The Gold.
- Do not split a single behavioral increment across multiple steps.
- Do not skip required intermediate steps to reach The Gold faster.
- The "Outside the Plan" section must always be last in TODO.md.
- Do not implement anything. This is a planning-only command.
