---
description: Normalize bibliography structure, sort entries and fields, and ensure mandatory fields are present with {NA} placeholders.
---

# Normalize References

Bring one bibliography file onto a consistent structure in a single guarded pass: sort entries alphabetically by citation key, ensure the mandatory fields are present with `{NA}` if missing, format syntax uniformly, sort fields into three alphabetical sections within each entry, and verify with a containerized smoke test. You change structure only; you never alter existing values.

## Scope

Modify the single bibliography file and nothing else. Never alter or overwrite an existing field value. Never remove a field. Never add, merge, split, or delete an entry, and never rename a citation key or change an entry type. The only field additions permitted are inserting missing mandatory fields with the `{NA}` placeholder. Normalize every entry, cited or not.

## Mandatory fields

Every entry must carry the following 17 mandatory fields:

- **Core bibliographic (3):** `author`, `title`, `year`
- **Classification (1):** `category`
- **Screening (13):** `abstract`, `analytical_methods`, `equations`, `island`, `keywords`, `limitations`, `objectives`, `research_question`, `results`, `software`, `species`, `time_period`, `variables`

If an entry lacks any of these 17 fields, add it with the value `{NA}`. Never alter an existing value in any of these fields.

## Field sections and ordering

Within each entry, fields are organized into three distinct sections, each sorted alphabetically (case-insensitively):

1. **Standard bibliographic fields (A–Z):** standard non-custom fields present in the entry (e.g., `author`, `booktitle`, `doi`, `journal`, `number`, `pages`, `publisher`, `title`, `url`, `volume`, `year`).
2. **Mandatory custom fields (A–Z):** the 14 project metadata fields (`abstract`, `analytical_methods`, `category`, `equations`, `island`, `keywords`, `limitations`, `objectives`, `research_question`, `results`, `software`, `species`, `time_period`, `variables`).
3. **Optional custom fields (A–Z):** any other custom, user-defined, or non-standard field not part of the mandatory set (e.g., project-specific review or tracking fields), sorted alphabetically.

## Formatting syntax

Write every entry following uniform syntax:

- One entry per block, separated by exactly one blank line.
- Opening line: `@<type>{<citekey>,`.
- Fields on their own line: `  <field> = {<value>},` (two-space indentation, one space on each side of `=`, values enclosed in braces, and a trailing comma).
- Every field line opens with `field = {` and closes with `},` on the same line.
- Closing line: `}`.

## Inputs

- The bibliography: `$ARGUMENTS` as a path if given, otherwise the single `.bib` in the git top level. Zero or several: report and stop.
- The working tree must be clean at the start (`git status --porcelain`). Stop and report otherwise.
- Run `pandoc` in the project container. Discover the one running container; zero or several: stop and ask.

## Steps

1. **Read & Inventory:** Read the bibliography file. Assert non-zero entries and non-zero bytes; if either is zero, stop and report. Count entries, entry types, and field frequencies.
2. **Sort entries:** Sort entries in memory alphabetically by citation key, case-insensitively and stably. Two keys equal under case folding keep their relative order.
3. **Structure entries:** For each entry:
   - Identify missing mandatory fields from the 17-field list and add them with value `{NA}`.
   - Partition fields into the three sections: standard bibliographic, mandatory custom, optional custom.
   - Sort fields within each section alphabetically (A–Z).
   - Format each field as `  <field> = {<value>},`.
4. **Guard:** Compare the constructed file in memory with the current disk file. If they are identical, report that the bibliography is already fully normalized and stop without writing. Only a real difference proceeds to step 5.
5. **Write:** Write the normalized file to disk once. Verify that every field line matches `field = {` ... `},` and that the file parses without syntax errors. If verification fails, run `git restore` on the file, report the failure, and stop.
6. **Smoke test:** Run the pandoc smoke test in the container (see below). If assertions fail, report pandoc's error, state that `git restore` restores the clean state, and stop.
7. **Report:** Report summary inventory, entries reordered, fields added with `{NA}`, show the diff, state that the working tree is dirty, and state that you staged and committed nothing.

## Smoke test

Write `/tmp/citeall.md` inside the container, citing every key in the bibliography, and render it:

```bash
docker exec <container> pandoc --citeproc --bibliography=<BIB_FILE> -t plain /tmp/citeall.md -o /tmp/citeall.txt
```

Assert:
- `pandoc` exits zero with no parse warning.
- The document renders to `/tmp/citeall.txt`.
- The rendered reference list is non-empty.
- The count of rendered references equals the total entry count.

If an assertion fails, stop, report which assertion failed along with pandoc's error and counts, state whether the tree is dirty and that `git restore` returns it to clean state, and stand by.

## Report

Give:
- The inventory: entry count, entry types, and count of missing mandatory fields added.
- The list of citation keys modified and fields inserted with `{NA}`.
- The smoke test result.
- If the guard stopped execution, report that the file already conforms to house style and show no diff; skip the smoke test.
- Otherwise, show the unified diff.
- State whether the tree is dirty and that you staged and committed nothing.

## Constraints

- Structure and missing mandatory fields only: never alter or overwrite existing values, citation keys, or entry types.
- No scratch files inside the repository; use `/tmp` in the container.
- No `git add`, `git commit`, or staging commands.
