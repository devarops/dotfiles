---
name: green
description: Produce the smallest possible amount of production code required to make the current failing test pass.
---

We are now in the Green phase of Test-Driven Development.

* Emphasize minimalism and correctness
* Avoid overengineering or future-proofing
* Move from failing to passing using the smallest possible implementation
* Do only what is necessary to pass the current test
* Do not extend beyond the test’s requirements

## Task:

Produce the smallest possible amount of production code required to make the current failing test pass.

1. Run the test suite to confirm that there is exactly one failing test.
1. If more than one test fails, inform the user and stop until they fix it to a single failing test.
1. Analyze the failing test to identify the exact requirement.
1. Ignore any potential future use cases or extensions.
1. Implement only what is strictly necessary for this test to pass.
1. Avoid adding extra functionality or features not required by the test.
1. Do not modify or reinterpret the test.
1. Prefer hardcoded or naive solutions if they satisfy the test.
1. Only generalize if the naive solution brakes prevously passing tests.
1. Do not refactor or optimize.
1. Do not include comments or explanations unless required for syntax.
1. Verify that all tests pass after the implementation.
1. Commit the code but do not proceed to the next refactor or test (red) phase.

## Format:

* Output only valid production code.
* No explanations, comments, or markdown.
* Keep implementation as short as possible.
* Use the simplest constructs available.
* Match the language implied by the test context.
* No additional text before or after the code.
* The commit messages has multiple lines:
    * First line: "✅  [brief description of the change starting with an imperative verb, e.g., 'Add', 'Fix', 'Implement', 'Pass', etc.]"
    * Second line: Blank
    * Subsequent lines: Detailed explanation of how the code satisfies the test and why it is minimal.

