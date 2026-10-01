---
description: Fill a bibliography's screening block one reference at a time, reading each reference's own PDF, and stop for the author to approve each record.
---

# Screen References

You fill in a screening block of descriptive fields in a bibliography file, one
reference at a time. Each reference is read from its own PDF. Each record is
written, then explained, then approved, one record per round trip.

The block is a worksheet, not a citation database. Its purpose is that the author
can find out later what a source says and how far it can be trusted, without
reopening the PDF. Every value must therefore be traceable to the source, and a
value you cannot trace is a value you must ask about.

## Scope

Fill the screening fields of one bibliography file, one reference at a time.

Out of scope, and unchanged by this command: entry types, author lists, titles,
journals, volumes, pages, DOIs, URLs, and the order of entries. If a record
contradicts its own source — a thesis typed as an article, a truncated author
list — report it and leave it.

`category` is assigned by `reference-classify.md`, not by this command. Do not
write it.

## Inputs

Everything is discovered in the working directory. Do not hardcode a path from a
previous use of this command.

- **The bibliography file.** `$ARGUMENTS` if the author named one; otherwise the
  single `.bib` in the working directory.
- **The reference PDFs.** One file per reference, named after its citekey with a
  `.pdf` suffix. Match on citekey, never on a bare `*.pdf` sweep.
- **The extracted text.** One `.txt` per PDF, at the same path as its PDF with
  the extension swapped.

## The extracted text

Read the `.txt`, not the PDF.

```bash
pdftotext references/afan2018adaptive.pdf references/afan2018adaptive.txt
```

- **Never regenerate a `.txt` that already exists.** If it is there, read it.
- Do not produce a second file with a different flag. There is one `.txt` per
  PDF, plain single-column output, and it is the only extraction you use.
- The `.txt` files are derived from PDFs the repository already holds. They are
  a working cache and are gitignored; that is correct and expected.
- Check the extraction before trusting it. A PDF that is a scan has no text
  layer, and a `.txt` of a few hundred bytes means OCR is needed. Report it
  rather than writing values from a title.

Where a word is split across a line break, or a two-column page interleaves,
reconstruct the sentence before you read meaning into it. Grep for the specific
number or term rather than trusting the surrounding flow, and re-grep it in the
`.txt` before writing it into any field.

## Fields

These are the values written to the file, with the rule that decides each.

| Field | What goes in it |
|---|---|
| `abstract` | A 50 to 100 word **verbatim** quotation from the reference's own abstract, or its own Justification or Summary if it has no abstract. Never paraphrased, never blended. |
| `island` | The place the evidence comes from. `Global` only when the source says global or spans multiple oceans or countries. `not_applicable` when the work has no study site, such as a methods or software paper. |
| `species` | The taxa the work is about, at group level where the source uses groups. Capital first letter of each item. |
| `time_period` | The span of the evidence: the years the data or review cover. Not the publication year. `not_applicable` when no period applies. |
| `research_question` | The knowledge gap, in one sentence, in the source's own framing. `not_applicable` when the source states none. |
| `objectives` | The ordered list of what the source sets out to do, in its own order, most important first. The "we did Y" half. |
| `variables` | The quantities the work measures or examines. |
| `analytical_methods` | The procedures, in the order the source presents them. Name functions, packages, and tests where the source names them. |
| `results` | The findings, with the source's own numbers. |
| `equations` | A short identifier of each mathematical object, not a formula. `not_applicable` when the work has no mathematics. |
| `software` | Proper nouns only: packages, tools, versions the source states. `not_applicable` when none is named. |
| `limitations` | The uncertainties the authors state themselves, not caveats you infer. |
| `keywords` | The source's own keywords where it has them, capital first letter of each item. |

### Question and objective

`research_question` and `objectives` are not synonyms, and the distinction comes
from Joshua Schimel, *Writing Science* (2012), chapter 7, sections 7.2 and 7.3.
Schimel argues that objectives come **after** the question and stand in for it
only when the author has failed to state one. So:

- The question is the knowledge gap. The objectives are what will be done to
  close it.
- A source may state a question, a hypothesis, objectives, any two, or all
  three. Fill what is there.
- A source that states objectives and no question has a weak challenge. Record
  `research_question` as `not_applicable` and say so in your report. Do not
  manufacture the question by inverting the objectives.
- **A hypothesis is never promoted into `research_question`.** Schimel is
  explicit that a hypothesis is a falsifiable prediction derived from the
  question, and that the question remains the key. Report the hypothesis as a
  missing question.
- `objectives` is an ordered list, and the order is information. Schimel shows
  that misordering the objectives signals a weak challenge. Do not sort it.

### Markers

Two markers, used for different things. Never use a bare `NA`, and never use
`TODO` for something that does not apply.

- `not_applicable` — the field does not apply to this reference. Nothing is lost
  and nothing is pending.
- `TODO` — the value is genuinely still to be found. A record should not be left
  holding one unless you asked the author and they deferred it.

### Lists

Semicolon-delimited, capital first letter of each item, no title case:

```
Analytical methods: Literature review; Data extraction; Gap analysis
```

Do not delimit with commas. A value may contain a comma, and a number such as
44,000 will silently split the list.

### Verbatim and written fields do not share a case rule

`abstract` and a source's own `keywords` reproduce the source's casing, including
lowercase. Every list field you write uses capital first letter per item. Do not
"fix" the casing inside a quotation.

## Length

**No field exceeds 100 words.** This applies to every field in the block, on
every reference, whether you composed the value or quoted it.

The block is a screening instrument. It exists so the author can tell what a
source says and how far it can be trusted without reopening the PDF, and it is
read as a column. A cell that runs to several hundred words stops being scannable
and stops being comparable with the cells beside it, which is the whole point of
putting these fields in a table.

Where the author can always return to the article, the article wins on detail.
A `.txt` is one command away.

### What to cut, in order

Cut until the field fits. Take from the outside in, in this order:

1. **Provenance.** Which database, archive, or survey the data came from; tag
   duty cycles; accuracy classes; filter thresholds stated as numbers.
2. **Mechanical steps.** Re-sampling intervals, projection choices, and
   intermediate artefacts that the next step overwrites anyway.
3. **Named tests.** Keep the test and drop the post-hoc comparisons it required.
4. **Restatements of another field.** If `results` already carries the finding,
   `analytical_methods` does not need to promise it again.

What you keep: the procedures, the quantities, and the findings, with their
numbers. A reference whose methods run to seven steps will sit near the limit
while a reference with three steps sits near thirty. That gap is information
about the paper, not a defect to even out.

### Report what you cut

Say which fields you shortened and what went. When a cut removes something the
author may want, name it and let them decide, as in "dropping the data-gap clause,
which the limitations field also records". Do not quietly trim, and do not wait
to be asked.

### `abstract` is a quotation under a tighter limit

`abstract` carries its own 50 to 100 word rule, so the general limit rarely binds
there. When the source's abstract runs longer, take a contiguous span and say
which part you left out. If the omitted part carries numbers the paper exists to
report, name those numbers as dropped so the author can ask for them.

## Constraints

- Change only the fields listed above, on one reference per round trip. Leave
  every other field, and the file's entry order, as they are.
- Add no fields. If the block is missing a field the author wants, ask; do not
  add one because a reference seemed to call for it.
- Never write a value you did not read in the source or that the author chose.
  This is the one rule that overrides speed.
- Never write a field over 100 words. If a value cannot be shortened without
  losing a procedure, a quantity, or a finding, stop and offer the author a
  choice: cut the detail, split it into a new field, or accept an exception.
  Do not resolve this yourself.
- Do not search the web to fill a field while text remains unread in the `.txt`.
  Read first. When the `.txt` cannot answer, say which field and why, and offer
  options rather than a guess.
- Do not commit, and do not run `git add`. Staging is the author's decision.
- Do not carry a value from one reference to another because the references
  resemble each other. Similar sources are where transcription errors live.

## Actions

### Step 1 — check the file is writable and well formed

Read the bibliography. Count the references, list the fields the block has, and
list the references already filled. Report which references remain, in the order
they appear in the file.

Confirm that adding a value cannot corrupt the entry: every field line must still
open with `field = {` and close with `},` on the same line. A multi-line value is
a defect, and if a replacement drops the closing brace the entry runs into the
next one. Verify after writing, and repair before reporting.

### Step 2 — one reference

```bash
pdftotext references/<key>.pdf references/<key>.txt   # only if absent
```

1. Read the `.txt`. Identify what kind of work it is: an empirical study, a
   review, a methods or software paper, a policy document, an assessment, a
   thesis, a meeting record. The kind decides several fields, since a review has
   no study site and a software paper has no species.
2. Locate, by grep, each field's evidence: the abstract or Justification, the
   study area, the taxa, the years, the question, the objectives, the methods,
   the results, the mathematics, the software, the caveats, the keywords. Where a
   section is missing, that is the answer, not a gap to fill.
3. Re-grep every number you intend to write.
4. Write the record. Change nothing else.
5. Check every field against the 100 word limit. Trim the ones that fail, in the
   order given under `## Length`, and keep a note of what you cut for the report.
6. Verify the entry is still well formed and the file still parses.
7. Report, then stop.

### Step 3 — report

For the reference just written, state:

- which fields are verbatim from the source, and which you composed;
- every number you recorded, with the line it came from;
- any field you shortened to fit the limit, and what you dropped from it;
- which fields took a marker, and why that marker rather than the other;
- anything in the source that contradicts its entry, left unchanged;
- any field you could not settle, with options rather than a guess.

Keep the report proportional. For a record where every field was read off the
page, that is two or three sentences, not an inventory of the fields. The author
reviews with `git diff` and does not need the diff described back to them.

If you composed a value rather than reading it — and `research_question` is
composed for every source that states none — say so explicitly. Composed values
are the ones the author most needs to check.

### Step 4 — wait

Stop. The author approves or requests changes with `git diff`. Do not begin the
next reference until they respond.

## Completion

Stop after each reference's approval. Do not proceed to the next one, and do not
commit. When the last reference is approved, report the whole run: references
filled, markers used and where, composed values the author should re-check, fields
trimmed to the limit and what went out of them, and contradictions between sources
and entries that were left in place.

### Auditing the finished block

Once every reference is filled, count words per field and compare the columns.
A field whose median is far above its neighbours usually means the record carries
detail that belongs in the article rather than the table, and the author should be
told which one and by how much.
