---
description: Interview the user using a Clarity Worksheet and write answers in a Markdown file
---

# Phase 1: Interview

The Clarity Worksheet is provided in $1.
The answers file is provided in $2.

## Validation

- Verify $1 exists and is readable.
- Verify $1 has at least one `- [ ]` question. If not, notify the user and stop.
- $2 may or may not exist. If it exists, the user is resuming previous work.

If validation fails, notify the user and stop. Otherwise proceed.

## Process

- If $2 exists and is not empty, detect the language of $2. This is the language of $2 for the entire session.
- If $2 does not exist or is empty, detect the language of $1. This will be the language of $2 for the entire session.
- If $2 does not exist, create it as an empty file.
- Read every `##` heading from $1 and copy them into $2.
- For each `##` section in $1, starting from the first and proceeding top to bottom:
  - Skip questions already marked `- [x]` (answered in a previous session).
  - For each `- [ ]` question:
    - Present the question to the user.
    - Offer options for answers.
    - Indicate your recommended answer and justify it.
    - Wait for their input.
    - The options should be in the opposite language of $2.
    - The user should answer in the language of $2.
    - If the user answers in the wrong language, reject it and ask them to answer in the correct language.
    - If the user rejects your recommendation, let them explain why and try again.
    - Fix grammar and spelling in the user's answer before writing it, but limit changes to only those necessary for clarity and correctness.
    - If the user's answer is a fragment, add the minimum number of words needed to make it a complete sentence. Do not add more than is necessary.
    - The answer might be multiple sentences long; if so, write each sentence on its own line.
    - Write the answer under its corresponding `##` heading in $2. Do not write the question, only the answer.
    - Add a blank line after each answer to separate it from the next one.
    - Once answered, mark the question as `- [x]` in $1.
- After reaching the end of $1, ask the user to review and approve the answers written in $2. Commit if approved.
- Print a pass summary:
  - Pass N complete. X questions answered, Y questions still remain. Start pass N+1?
- If 0 questions were answered or 0 questions remain, print a completion message and stop. Otherwise, wait for the user to confirm the next pass.
