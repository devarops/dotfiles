---
description: Replace placeholders in a Markdown file by interviewing the user and refining their answers
---

# Phase 2: Replace Placeholders

- The target Markdown file is provided as `$ARGUMENTS`.
- For each `[[ ... ]]` or `XXX` placeholder found in the file:
  - ask the user the corresponding question implied by its context,
  - offer options for answers,
  - indicate your recommended answer,
  - justify your recommendation, and
  - wait for their input.
- Present one placeholder at a time. Only move to the next one after the user has provided input for the current one.
- The user speaks English and Spanish. Speak to the user in English.
  - Present the options in the opposite language of the file.
  - The user should answer in the language of the file.
  - If the user answers in the wrong language, reject it and ask them to answer in the correct language.
- The options for each placeholder should be concise phrases that capture the essence of the answer, not full sentences.
- Fix grammar and spelling in the user's answer before writing it in place of the placeholder, but limit changes to only those necessary for clarity and correctness.
  - If the user's answer is a fragment, add the minimum number of words needed to make it a complete sentence.
  - Do not add more than is necessary.
- If the user rejects your recommendation, let them explain why and try again.
- After reaching the end of the file, print a pass summary:
  - Pass N complete. X placeholders replaced, Y placeholders still remain. Start pass N+1?
- If 0 placeholders were replaced or 0 placeholders remain, print a completion message and stop. Otherwise, wait for the user to confirm the next pass.
- Commit after each pass.
