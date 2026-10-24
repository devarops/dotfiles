---
description: Extract screening fields and fill NA fields from each reference's own source, except category.
---

# Extract References

Fill the screening fields of one reference at a time, and any existing NA field other than `category`, from that reference's own source. Write the record, explain it, and stop. Every value must trace to the source; a value you cannot trace, ask about instead of guessing.

## Scope

Own the thirteen screening fields below, plus any existing field other than `category` whose value is `NA`, `na`, `N/A`, or empty, one reference per round trip. Change nothing else: entry types, entry order, and well-formed populated fields stay as they are. Add a missing screening field when you fill it; never add a non-screening field that was not already present. For non-screening fields, infer formatting conventions from the other references in the bibliography. If a record contradicts its own source, report it and leave it.

## Inputs

- The bibliography: the single `.bib` in the git top level; zero or several, report and stop.
- `$ARGUMENTS`, a citekey: process that reference even if complete. No argument: process the file in order, one reference at a time.
- Skip a reference whose screening fields are all present and well formed, and has no existing field other than `category` containing `NA`, `na`, `N/A`, or an empty value; report it as skipped, not re-verified.
- The source: `<citekey>.pdf`, anywhere in the repository, with its `.txt` beside it. No source: report it and leave that reference.
- The working tree must be clean at the start. Stop and report otherwise.
- Run `pdftotext` in the project container. Discover the one running container; zero or several: stop and ask.

## The text

Read the `.txt`, creating it once with `docker exec <container> pdftotext <pdf> <txt>` if absent; never regenerate. A scan has no text layer: a `.txt` of a few hundred bytes needs OCR, so report it and do not fill from the title. Reconstruct words split across lines and columns before reading meaning into them.

## Fields

| Field | What goes in it |
|---|---|
| `abstract` | A verbatim 50 to 100 word span from the source's abstract, or from its justification or summary if it has none; never paraphrased or blended. |
| `island` | Where the evidence comes from; `Global` only if the source says global or spans multiple oceans or countries, `not_applicable` for work with no study site. |
| `species` | The taxa the work is about, at the source's group level. |
| `time_period` | The years the data or review cover, not the publication year; `not_applicable` if none applies. |
| `research_question` | The knowledge gap, one sentence, in the source's own framing; `not_applicable` if the source states none. |
| `objectives` | The ordered list of what the source sets out to do, in its own order, most important first. |
| `variables` | The quantities the work measures or examines. |
| `analytical_methods` | The procedures in the source's order; name functions, packages, and tests where it names them. |
| `results` | The findings, with the source's own numbers. |
| `equations` | A short identifier of each mathematical object, not a formula; `not_applicable` if none. |
| `software` | Proper nouns only: packages, tools, and versions the source states; `not_applicable` if none. |
| `limitations` | The uncertainties the authors state themselves, not caveats you infer. |
| `keywords` | The source's own keywords. |

### Question and objective

Objectives without a question: `not_applicable`, never invert them. A hypothesis is not a question.

### Markers

`not_applicable` when the field does not apply; `TODO` only when the author deferred a value still to be found. Never a bare `NA`.

### Lists and case

Semicolon-delimited, capital first letter per item, no title case; never commas, since a value may contain one. `abstract` keeps the source's casing.

## Length

No field exceeds 100 words. Cut provenance and mechanical detail before procedures, quantities, and findings; if a value cannot shorten without losing one of those, stop and offer the author a choice. Report what you cut.

## Filled values

Empty, or placeholder (`NA`, `na`, `N/A`): fill, except in `category`. Well formed: leave. Breaking a rule above: repair and report. Disagreeing with the source: report and ask, never overwrite. If an existing NA field other than `category` cannot be traced with certainty in the source, ask the author with options instead of guessing.

## Steps

1. Read the record and the `.txt`; identify the work: empirical study, review, methods or software paper, policy document, assessment, thesis, or meeting record.
2. Grep each field's evidence, then re-grep every number.
3. Write the fields that need filling, positioning an added field where other records place it, else last. Trim to the word limit.
4. Verify that every field line still opens with `field = {` and closes with `},` on the same line, and that the file parses; repair before reporting.
5. Report, then stop.

## Report

State which fields are verbatim and which composed, every number with its source line, every field trimmed and what left it, which fields took a marker and why, any contradiction left in place, and any open question with options. Show the diff. A clean record takes two or three sentences. If nothing needed filling, say so. After the last reference, give the whole run, state whether the tree is dirty, and state that you staged and committed nothing.

## Constraints

- Never write a value you did not read in the source or the author chose.
- Never write, repair, or use `category` as evidence: leave it exactly as found, whatever its value.
- Never carry a value between references because they resemble each other.
- No `git add`, no `git commit`, no staging.
