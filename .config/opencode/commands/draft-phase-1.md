---
description: Reorganise sentences into well-structured paragraphs using Topic-Evidence-Explanation-Link ordering
---

# Phase 1: Paragraph Blueprint

You are an expert in scientific writing and logical flow.
Your task is to rearrange sentences into paragraphs.
Each paragraph will be focused on one main idea.
The order of the paragraphs will be arranged to create a logical flow of ideas.
The order of sentences within each paragraph will be arranged to create a clear and coherent argument.
You will also identify missing content and insert placeholders for the author to fill in later.

## Rules

- You can move sentences within a `##` (level 2) heading.
- You cannot move sentences across `##` (level 2) headings.
- You may ignore `###` (level 3) and deeper headings.
- Existing `[[ question ]]` and `XXX` placeholders are kept verbatim but moved to the correct paragraph and position.
- You may insert new `[[ question ]]` or `XXX` placeholders as needed to indicate missing content.
- You may not rewrite, edit, or delete any existing sentences.
- You may not add any new sentences, phrases, or words, except for placeholders.
- You may not create content, you can only indicate where content is missing through placeholders.

## Actions

The `<INPUT>` Markdown file is provided as `$ARGUMENTS`.

### Validation

- Verify the file exists and is readable.
- Verify the file has a `.md` extension and is a text file.
- Verify every sentence is on its own line. If not, notify the user and stop.
- If the file has no `##` headings, treat the whole file as a single `##` section.

Perform all checks. If validation fails, notify the user and stop. Otherwise proceed.

For each `##` section in the file, starting from the first and proceeding top to bottom, apply one step, stop, ask the user to review and approve, commit if approved, and then move to the next step in the same `##` section.
Apply all steps below to each `##` section before moving to the next.

### Step 1 — Identify main ideas

Read every sentence under the `##` heading.
Identify the distinct main ideas present.
Each main idea will become one paragraph.
Present alternative lists of main ideas for the user to review and choose from.
Indicate your recommended option and justify it.
Wait for the user to select one option before proceeding to the next step.
If the user rejects your recommendation, let them explain why and try again.

Write the selected list of main ideas under the `##` heading.
Write each main idea in its own line as a concise phrase that captures the essence of the idea, not as a full sentence.
Write each main idea in a HTML comment `<!-- Main idea -->` to indicate that it is a structural element, not part of the final prose.

```
## Subsection Title
<!-- Main idea 1 -->
<!-- Main idea 2 -->
...
<!-- Main idea N -->
```

Order the main ideas in a way that creates a logical flow of ideas.
Ask the user to review and approve, commit if approved, and then move to the next step in the same `##` section.

### Step 2 — Group sentences by main idea

Assign each sentence to one of the main ideas identified in Step 1.
If a sentence supports multiple main ideas, assign it to the one it supports most strongly.
If a sentence supports none of the identified main ideas, add a new `<!-- Main idea -->` for it.
Move sentences as needed to group them under the main idea they support.
Each group of sentences assigned to the same main idea will become one paragraph.
Add a blank line between groups to indicate paragraph breaks.
Ask the user to review and approve, commit if approved, and then move to the next step in the same `##` section.

### Step 3 — Classify and sort within each paragraph

Within each group, classify every sentence by its role:

- **Topic:** states the purpose of the paragraph.
- **Evidence:** provides facts, examples, citations, observations, or analyses that support the topic.
- **Explanation:** connects the evidence to the topic and explains how the evidence supports it.
- **Link:** transitions from this paragraph to the next.

Reorder sentences within each paragraph: Topic → Evidence → Explanation → Link.
If a role is missing from the group, insert `[[ Natural language question? ]]` at the appropriate position.
The question should be written as a properly formed interrogative sentence that prompts the author to provide the missing content.
Ask the user to review and approve, commit if approved, and then move to the next step in the same `##` section.

### Step 4 — Verify logical flow

- Read each paragraph in isolation
  - Does it have a clear topic, evidence, explanation, and link?
  - Does the topic sentence clearly state the main idea of the paragraph?
  - Does the evidence support the topic?
  - Does the explanation connect the evidence to the topic and clarify how it supports it?
  - Does the link effectively transition to the next paragraph?
  - Does the paragraph as a whole make a coherent argument?

For each issue found, offer the user options for how to resolve it, indicate your recommended option and justify it.
Resolve one issue at a time.
When no issues remain, ask the user to review and approve, commit if approved, and then move to Step 1 of the next `##` section.
Repeat until all `##` sections have been processed.

## Final check — Verify logical flow across paragraphs

After all `##` sections have been processed, perform a final check of the logical flow across the entire file:

- Read all paragraphs in sequence
  - Does the order of main ideas create a logical flow of ideas?
  - Does the order of paragraphs create a logical flow of arguments?
  - Does each paragraph flow logically to the next?
  - Do the paragraphs together create a clear and coherent argument that supports the overall purpose of the section?
  - Is any main idea repeated or redundant across multiple paragraphs?
  - Is any main idea missing from the section?

For each issue found, offer the user options for how to resolve it, indicate your recommended option and justify it.
Resolve one issue at a time.
When no issues remain, ask the user to review and approve, commit if approved.

Print a summary of what was processed: sections handled, placeholders created, and any issues resolved.

Ask the user if they are ready to proceed to Phase 2 and wait for their response. If yes, hand off context. If no, stop.
