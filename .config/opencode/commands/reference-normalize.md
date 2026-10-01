---
description: Normalize the structure and fields of a bibliography file to the house style the file's own majority already uses, one record at a time.
---

# Normalize References

You normalize the structure of one bibliography file. You infer the house style
from the file itself, then bring every record onto it, one record at a time,
explaining each change and waiting for the user to approve it.

You change structure and fields. You never change bibliographic content. If a
record is missing information, you do not supply it and you do not look it up.
Filling in values is a different command's job.

## Scope

Modify `<BIB_FILE>` and nothing else. Any change to another file requires the
user's explicit approval first.

You will find real defects in other files, in the bibliography's consumers, and
in the build system. Do not fix them. Report them in your final message so the
decision is preserved rather than lost.

The bibliography is independent of every file that reads it. No decision you
make may depend on which records are cited, which documents cite them, or
whether a record is cited at all. Normalize every record, cited or not.

## Inputs

- **The bibliography file.** `$ARGUMENTS` if the user named one; otherwise the
  single `.bib` in the working directory. If discovery finds zero or more than
  one, stop and ask. Never pick a candidate.
- **A clean working tree.** If `<BIB_FILE>` is modified or untracked, stop and
  report. A before-state you have not reviewed makes every diff meaningless.
- **`pdftotext` is not used.** Do not extract text from PDFs, and do not read
  the references' PDFs at all. This command never reads a cited work.

All commands run inside the project container:

```bash
docker exec <container_name> <cmd>
```

The cite-all document is a temporary file outside the repository. Never write a
scratch file into the project.

## Pass 1 — Infer the house style

Discover before editing. Every decision in pass 2 depends on what you find here,
so do not skip it.

### 1. Confirm the inventory

Confirm `<BIB_FILE>` is the only bibliography. Count the entries, the entry
types, and the per-entry field sets. Record the field ordering within entries,
the spacing around `=`, and whether each entry has a trailing comma.

**Assert that you read a non-zero number of entries and a non-zero number of
bytes. If either is zero, stop and report.** A discovery pass that silently reads
nothing produces a confident, wrong report, which is worse than no report.

Record for every field: how many records carry it, and how many lack it. This
distribution decides what counts as a house field.

### 2. Sort the file

Sort entries alphabetically by citation key, case-insensitively, and stably. Two
keys that compare equal under case folding keep their original relative order, so
the sort is reproducible across runs.

Do not use a locale-aware comparison. The container's locale is an environment
detail, and a bibliography that reshuffles between machines is worse than one
with a consistent order.

Sorting happens here, before any record is processed, so that pass 2's per-record
diffs show field changes and not reordering.

### 3. Infer the shared field order

Do not adopt the most common complete field ordering. Measure it: a real file
here had ten distinct orderings across thirty-one records, so "the majority
ordering" matches a minority and reformats the rest.

Instead, find the **longest prefix of field names held by at least half the
records**, and treat that prefix as the house order. Fields beyond the prefix
keep each record's existing relative order. Reorder a record's fields only as
far as the prefix reaches.

Report the prefix, the length, and the number of records supporting it. If no
prefix of two or more fields clears half the records, say so and impose no order
at all.

### 4. Infer the house field set

**Any field present in at least half the records is a house field, and must be
present in every record.** The threshold is inclusive: a field on exactly half
the records qualifies.

Record the inferred house set in your pass 1 report, with the count and percentage
for each field. Pass 2 enforces this set, so the user sees the basis for every
finding before the first record is written.

Note the failure this rule exists to catch. A file is often normalized once and
then a single new record arrives without the review block, which leaves the file
looking fine until the missing record is found. A file-level check reports "no
changes needed"; a field-count check reports the record that is short.

### 5. Smoke test

Verify the sorted file is well formed and still produces citations.

Generate a temporary Markdown file citing every key in the file, and render it:

```bash
pandoc --citeproc --bibliography=<BIB_FILE> -t plain /tmp/citeall.md -o /tmp/citeall.txt
```

Assert all four of the following. The command is a smoke test, not a comparison:
its purpose is to prove the file is well formed, not to detect what changed.

- pandoc exits zero, with no parse warning;
- the cite-all document renders;
- the rendered reference list is non-empty;
- the number of rendered references equals the entry count from step 1.

That last assertion is what closes the gap. A key that parses but fails to
resolve would still leave a non-empty list, so only the count detects it.

If any assertion fails, **stop, report which one failed, include pandoc's error
and both counts, ask how to proceed, and stand by.** Nothing has been written at
this point, so the file is untouched.

## Pass 2 — One record at a time

Process the records in their sorted order. One record per round. No exceptions.

### Per record

1. Compare the record against the house style from pass 1: syntax, field order
   against the prefix, house field set, and the review block.
2. Apply the mechanical fixes only:
   - one space each side of `=`, with braced values, `field = {value}`;
   - a trailing comma after the last field of every entry;
   - one blank line between entries;
   - reorder fields to match the house prefix;
   - place the review block last, in its own internal order.
3. Add any missing house field with the value `{NA}`, the placeholder the file
   already uses. **State explicitly, per record, that an added field is a
   structural placeholder and not a value.** `{NA}` in a bibliographic field
   asserts the field is known-empty, and a missing `journal` is not the same as a
   journal-less record. Report the fact; do not soften it.
4. **Report what you did not do.** If a record lacks a house field whose value
   cannot be derived, say so rather than implying a fix was skipped. Keep
   fixable changes and unfixable findings in separate lists, so the user can tell
   at a glance which items their approval can change.
5. Show the diff for this record alone.
6. **Stop and wait.** The user reads the diff and either approves or requests
   changes. Apply requested changes, show the diff again, and wait again. Move to
   the next record only after approval.

Do not process the next record in the same turn. Do not batch records. Do not
continue while a request is outstanding.

### Never

- Change a field's value. `{NA}` is the only value you may write, and only into
  a field that is absent.
- Change an entry type. Leave an entry typed `@article` even when it is really a
  thesis or report. Report the contradiction and the correct type.
- Change author lists, including initials style or any `and others`
  truncation. Report that a fallback citation style may render that literal token
  as a visible word.
- Change title capitalization or brace protection. Report that a case-folding
  style may lowercase names like package or taxon names.
- Add, remove, merge, or split entries. Do not fill in a missing volume, number,
  pages, DOI, or URL. Do not delete an entry that is cited nowhere.
- Rename a citation key. A key change is the one edit that could break a
  citation elsewhere, and it is not a structural change.
- Change a DOI, URL, or any other identifier.

Report every one of these as a known issue with its evidence. A decision left in
place and recorded is a decision; a decision silently dropped is not.

## After the last record

### Smoke test again

Re-run the cite-all render from pass 1, step 5. Same four assertions.

If any assertion fails, **stop, report which one failed, include pandoc's error
and both counts, state that all records have been written and that the tree is
dirty with no commit, ask how to proceed, and stand by.**

A failure here means the normalization broke something. Do not commit, do not
roll back, and do not continue.

### Report

Give the user:

- the pass 1 inventory: entry count, entry types, the inferred field-order
  prefix with its support, and the inferred house set with counts and
  percentages;
- the list of records processed, each with the changes made and the step that
  drove them;
- the total fields added with `{NA}`, and which records they went into;
- the items reported and not changed, as findings with evidence;
- the two smoke-test results, with the rendered count from each;
- **that the tree is dirty and that you did not commit.**

The user commits. A re-run before that commit will be refused by the clean-tree
check, so say so.

## Constraints

- Modify `<BIB_FILE>` and nothing else.
- Change no value that already exists.
- Add `{NA}` only to a field that is absent, and only when the field is a house
  field.
- Report rather than fix anything outside `<BIB_FILE>`.
- Do not run `git commit`, `git add`, or any other command that stages or
  commits. The user commits.
- Do not write scratch files into the project. Use `/tmp`.
- Stop and wait after every record.
