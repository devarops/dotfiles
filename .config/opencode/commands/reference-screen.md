---
description: Fill a bibliography's screening block one reference at a time, reading each reference's own PDF, and stop for the author to approve each record.
---

# Screen References

Fill the screening fields of one bibliography file, one reference at a time: read the reference's own PDF, write its record, explain it, then stop for approval. Every value must trace to the source; a value you cannot trace, ask about instead of guessing.

## Scope

Fill the screening fields of one bibliography file, one reference at a time. Leave entry types, authors, titles, journals, volumes, pages, DOIs, URLs, and entry order unchanged; if a record contradicts its own source, report it and leave it. `category` is written by `reference-classify.md`, not here.

## Inputs

Discover everything in the working directory; never hardcode a path from a previous run.

- Bibliography: `$ARGUMENTS` if named, else the single `.bib` in the working directory.
- Reference PDFs: one per reference, named after its citekey with a `.pdf` suffix. Match on citekey, never a bare `*.pdf` sweep.
- Extracted text: one `.txt` per PDF, at the same path with the extension swapped.

## The extracted text

Read the `.txt`, not the PDF.

```bash
pdftotext references/<key>.pdf references/<key>.txt   # only if absent
```

Never regenerate an existing `.txt`; read it. Do not produce a second file with a different flag: one plain, single-column `.txt` per PDF, and it is the only extraction you use. The `.txt` files are a working cache, gitignored; that is expected.

Check the extraction before trusting it. A scan has no text layer, and a `.txt` of a few hundred bytes means OCR is needed; report it rather than writing values from a title.

Where a word is split across a line break, or two columns interleave, reconstruct the sentence before reading meaning into it. Grep for the specific number or term, and re-grep it in the `.txt` before writing it into any field.

## Fields

These are the values written to the file, with the rule that decides each.

| Field | What goes in it |
|---|---|
| `abstract` | A verbatim 50 to 100 word span from the source's own abstract, or its Justification or Summary if it has none; never paraphrased, never blended. |
| `island` | Where the evidence comes from; `Global` only if the source says global or spans multiple oceans or countries, `not_applicable` for work with no study site. |
| `species` | The taxa the work is about, at the source's group level; capital first letter per item. |
| `time_period` | The years the data or review cover, not the publication year; `not_applicable` if none applies. |
| `research_question` | The knowledge gap, one sentence, in the source's own framing; `not_applicable` if the source states none. |
| `objectives` | The ordered list of what the source sets out to do, in its own order, most important first. |
| `variables` | The quantities the work measures or examines. |
| `analytical_methods` | The procedures in the source's order; name functions, packages, and tests where it names them. |
| `results` | The findings, with the source's own numbers. |
| `equations` | A short identifier of each mathematical object, not a formula; `not_applicable` if none. |
| `software` | Proper nouns only: packages, tools, and versions the source states; `not_applicable` if none. |
| `limitations` | The uncertainties the authors state themselves, not caveats you infer. |
| `keywords` | The source's own keywords, capital first letter per item. |

### Question and objective

`research_question` and `objectives` differ (Schimel, *Writing Science*, 2012, §7.2–7.3): objectives come after the question and stand in for it only when the author states none.

- Fill whatever the source states — a question, a hypothesis, objectives, or several.
- Objectives without a question is a weak challenge: record `research_question` as `not_applicable`, say so, and do not invert the objectives to manufacture one.
- A hypothesis is a falsifiable prediction derived from the question; never promote it into `research_question`. Report the missing question instead.
- `objectives` is an ordered list and the order is information; do not sort it.

### Markers

Never a bare `NA`, and never `TODO` for something that does not apply.

- `not_applicable` — the field does not apply; nothing is lost or pending.
- `TODO` — the value is still to be found; leave one only if the author deferred it.

### Lists

Semicolon-delimited, capital first letter of each item, no title case:

```
Analytical methods: Literature review; Data extraction; Gap analysis
```

Never comma-delimit: a value may contain a comma, and a number such as 44,000 would split the list.

### Verbatim and written fields do not share a case rule

`abstract` and the source's own `keywords` reproduce the source's casing, including lowercase; every list field you write takes capital first letter per item. Never fix the casing inside a quotation.

## Length

**No field exceeds 100 words** — composed or quoted, on every reference.

Cut until the field fits, from the outside in, in this order:

1. **Provenance** — database, archive, or survey; duty cycles; accuracy classes; numeric filter thresholds.
2. **Mechanical steps** — resampling intervals, projection choices, and interim artefacts.
3. **Named tests** — keep the test, drop the post-hoc comparisons it required.
4. **Restatements** — if `results` carries the finding, `analytical_methods` need not promise it again.

Keep the procedures, the quantities, and the findings with their numbers. A paper with seven method steps sits near the limit and one with three near thirty; that gap is information about the paper, not a defect to even out.

Report what you cut: name each shortened field and what left it, and flag anything the author may want. Do not quietly trim.

`abstract` carries its own 50 to 100 word rule, so the general limit rarely binds there. If the source's abstract runs longer, take a contiguous span, say which part you left out, and name any numbers the omitted part carries.

## Constraints

- Change only the fields above, one reference per round trip; leave every other field and the entry order as they are.
- Add no fields; if the block is missing one the author wants, ask.
- Never write a value you did not read in the source or that the author chose; this overrides speed.
- Never write a field over 100 words. If a value cannot shorten without losing a procedure, a quantity, or a finding, stop and offer the author a choice — cut the detail, split it into a new field, or accept an exception. Do not resolve it yourself.
- Do not search the web while text remains unread in the `.txt`; read first, then say which field and why, and offer options rather than a guess.
- Do not commit and do not run `git add`; staging is the author's decision.
- Do not carry a value from one reference to another because they resemble each other.

## Actions

### Step 1 — Check the file is writable and well formed

Read the bibliography; count the references, list the block's fields and the references already filled, and report which remain, in file order.

Ensure adding a value cannot corrupt an entry: every field line opens with `field = {` and closes with `},` on the same line. A multi-line value is a defect, and a replacement that drops the closing brace merges two entries. Verify after writing, and repair before reporting.

### Step 2 — One reference

1. Read the `.txt`, extracting it first if absent (see *The extracted text*), and identify the work: an empirical study, review, methods or software paper, policy document, assessment, thesis, or meeting record. The kind decides several fields — a review has no study site, a software paper no species.
2. Grep each field's evidence: the abstract or Justification, study area, taxa, years, question, objectives, methods, results, mathematics, software, caveats, keywords. Where a section is missing, that is the answer, not a gap to fill.
3. Re-grep every number you intend to write.
4. Write the record, changing nothing else.
5. Check every field against the 100 word limit; trim in the order above and note what you cut.
6. Verify the entry is still well formed and the file still parses.
7. Report, then stop.

### Step 3 — Report

For the reference just written, state: which fields are verbatim and which you composed; every number you recorded, with its source line; every field you shortened and what left it; which fields took a marker and why; any contradiction left unchanged; and anything unsettled, with options rather than a guess.

Keep the report proportional — a clean record is two or three sentences, not an inventory, since the author reviews with `git diff`. Say explicitly when you composed a value, as `research_question` is composed for every source that states none.

### Step 4 — Wait

Stop. The author approves or requests changes with `git diff`. Do not begin the next reference until they respond.

## Completion

Stop after each reference's approval; do not proceed and do not commit. When the last reference is approved, report the whole run: references filled, markers used and where, composed values to re-check, fields trimmed and what left them, and contradictions left in place.

Once every reference is filled, count words per field and compare the columns. A field whose median far exceeds its neighbours usually carries detail that belongs in the article; say which one and by how much.
