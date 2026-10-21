---
description: Normalize the structure of one bibliography file in a single pass, using the house style the file itself already uses.
---

# Normalize References

Bring one bibliography file onto its own house style in a single pass: sort the entries, infer the field order and field set the file already uses, rewrite syntax and order, and report what you did not change. You change structure only.

## Scope

Modify the bibliography file and nothing else. Never write, add, remove, or change a field value, and never add or remove a field. Never add, merge, split, or delete an entry, and never rename a citation key or change an entry type. Read no reference source. Normalize every record, cited or not. Report every absent house field and every contradiction with its evidence, and leave it in place.

## Inputs

- The bibliography: `$ARGUMENTS` as a path if given, otherwise the single `.bib` in the git top level. Zero or several: report and stop.
- The file must be tracked and unmodified, and the working tree clean. Stop and report otherwise: a before-state you have not reviewed makes the diff meaningless.
- Run `pandoc` in the project container. Discover the one running container; zero or several: stop and ask.

## Read

Report before writing: the entry count, the entry types, the per-field counts and percentages, the field orderings, and the spacing and comma conventions. Assert a non-zero entry count and non-zero bytes; if either is zero, stop and report.

Sort in memory by citation key, case-insensitively and stably, without locale. Two keys equal under case folding keep their relative order.

Find the longest prefix of field names shared, in the same order, by at least half the records, and report it with its support. Break a tie by the prefix whose records come first in the sorted file. If no prefix of two or more fields clears half, impose no order. Fields beyond the prefix keep their relative order, and a record lacking a prefix field keeps its own order.

A field on at least half the records is a house field. Report the house set with counts and every record that lacks one. You add nothing.

## Guard

Before writing, build the intended file in memory from the sorted entries, the inferred field prefix, the house field set, and the syntax and spacing the Write section requires. Compare it with the current file. If they are identical, report that the bibliography already matches the house style and stop without writing. Only a real difference reaches Write.

## Write

Write the guarded result once:

- one entry per block, one blank line between blocks;
- fields as `field = {value}`, one space each side of `=`;
- a trailing comma after the last field of every entry;
- fields reordered to the inferred prefix, and no further;
- entries in the sorted order.

Verify after writing that every field line opens with `field = {` and closes with `},` on the same line, and that the file parses; if either fails, stop, report, and restore the file with `git restore`.

## Smoke test

Write `/tmp/citeall.md` inside the container, citing every key, and render it:

```bash
docker exec <container> pandoc --citeproc --bibliography=<BIB_FILE> -t plain /tmp/citeall.md -o /tmp/citeall.txt
```

Assert: pandoc exits zero with no parse warning; the document renders; the reference list is non-empty; the count equals the entry count. If an assertion fails, stop, report which one, both counts and pandoc's error, state whether the file is dirty and that `git restore` returns it, and stand by.

## Report

Give the inventory, the prefix and its support, the field set with counts, the records that lack a house field, the entries changed by kind of change, and the smoke-test result. If the guard stopped, report that the file already matched and show no diff; the smoke test does not run. Otherwise show the diff. State whether the tree is dirty and that you staged and committed nothing. If the tree is dirty, the user commits; a second run before that commit is refused by the clean-tree check.

## Constraints

- Structure only: no value, field, key, or type.
- No scratch file inside the repository; write it in the container's `/tmp`.
- No `git add`, `git commit`, or any staging command.
