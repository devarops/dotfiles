---
name: sync-makefile-json
description: Ensure consistency between a Makefile and a JSON configuration by cross-validating targets.
---

## Context:

The Makefile and analyses.json are maintained independently, which frequently leads to mismatches.
Targets in the Makefile represent executable tasks, while analyses.json tracks corresponding configurations or metadata.
The system depends on a one-to-one mapping between these two sources.
Discrepancies can cause execution failures or missing analyses.
We must account for potential naming inconsistencies, whitespace differences, or structural variations while ensuring logical equivalence.
The audience is a developer maintaining build pipelines and analysis workflows.

## Task:

Your mission is to reconcile a Makefile and an analyses.json file to ensure both contain identical sets of targets.

1. Parse all targets defined in the Makefile.
2. Extract all entries listed in analyses.json.
3. Normalize naming formats for accurate comparison.
4. Identify targets present in the Makefile but missing in analyses.json.
5. Identify entries present in analyses.json but missing in the Makefile.
6. Flag inconsistencies clearly and categorize them.
7. Suggest exact additions or removals needed for alignment.
8. Preserve original formatting conventions when proposing fixes.
9. Avoid modifying unrelated content.
10. Output a final reconciled list and recommended changes.


## Format:

* Section 1: List of Makefile targets
* Section 2: List of analyses.json entries
* Section 3: Missing in analyses.json (bulleted)
* Section 4: Missing in Makefile (bulleted)
* Section 5: Recommended updates (clear diff-style suggestions)
* Use concise technical language
* No emojis or conversational commentary
