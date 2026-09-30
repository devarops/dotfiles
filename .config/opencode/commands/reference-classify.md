---
description: Assign one functional category to each bibliography reference and record it in the bibliography file.
---

# Classify References

You classify references by the job each one does in the literature. Read every
reference, then decide each one's function with the whole set in view, and write
the results into the bibliography file.

## Scope

Classify the references of one bibliography file. One category per reference,
written to that reference's `category` field.

Two terms, used strictly throughout:

- **Reference** — the paper being cited, someone else's work.
- **Manuscript** — the paper being written, the user's own work.

A reference's category is a property of the reference itself. It does not depend
on the user's project, on the user's manuscript, or on how or where the user
cites it. The same paper is `Methods` in every thesis that cites it.

Two categories are relational and cannot be decided by reading a reference
alone. `Classic` asks whether a work is widely used, and `Similar work` asks
what a reference is compared against. The comparison set for both is the
reference set itself, never the user's manuscript.

## Inputs

Everything is discovered in the working directory. Do not assume any project's
layout, and do not hardcode a path from a previous use of this command.

- **The bibliography file.** `$ARGUMENTS` if the user named one; otherwise the
  single `.bib` in the working directory.
- **The reference PDFs.** One file per reference, named after its citekey with
  a `.pdf` suffix, located anywhere in the working directory. Match on citekey,
  never on a bare `*.pdf` sweep — that also matches figures and stray files.
- **Publication years.** From each entry's `year` field.

The manuscript is not an input. When this command says PDF, it always
means the references' own PDFs, never a PDF of the user's manuscript.

A reference whose PDF is absent is still classified, from the bibliographic
record, and reported as classified without a PDF read.

## Core Principle

Classify by the function the reference performs in the literature, not by the
subject area it covers.

One category per reference. Stop at the first step that matches.

Judge each reference against the whole set, not in isolation. A work's function
is often visible only relative to its neighbours — a foundational method may
read as a conceptual paper until you see the later work built on it.

## Categories

These seven strings are the values written to the file. Write them exactly, in
this capitalisation.

- Methods
- Key concepts
- Similar work
- State of the art
- Justification
- Background
- Classic

## Decision Algorithm

Follow this sequence **in order**. Stop at the first condition that evaluates to true.

```
INPUT: $REFERENCE — one cited reference
EVIDENCE: the reference's own PDF, and the survey of the whole reference set

STEP 0 — Recency gate
LET $CURRENT_YEAR be the current year
LET $AGE be $CURRENT_YEAR minus the publication year of $REFERENCE
IF $AGE is 10 or more
THEN $REFERENCE cannot be State of the art

STEP 1 — Methods
IF $REFERENCE presents, validates, or implements a technique, model, dataset,
or analytical procedure
THEN classify as Methods
EXIT

STEP 2 — Key concepts
IF $REFERENCE defines a concept, framework, variable, or theoretical construct
THEN classify as Key concepts
EXIT

STEP 3 — Similar work
IF $REFERENCE addresses the same question, system, species, or methodology as
the other work it is compared against
THEN classify as Similar work
EXIT

STEP 4 — State of the art
IF $AGE is less than 10
AND $REFERENCE synthesises or represents recent advances, current knowledge, or
unresolved debates in its area
THEN classify as State of the art
EXIT

STEP 5 — Justification
IF $REFERENCE establishes the importance, scale, or urgency of a problem, or
identifies gaps, risks, or unsolved problems in existing work
THEN classify as Justification
EXIT

STEP 6 — Classic
IF $REFERENCE is a foundational or historically influential work that
established a widely used theory, method, or paradigm
THEN classify as Classic
EXIT

STEP 7 — Background
IF $REFERENCE provides general descriptive or contextual information about its
subject
THEN classify as Background
EXIT

STEP 8 — Catch-all
IF no step above matched
THEN classify as Background
EXIT
```

**The recency gate is evaluated against the current year.** Being newer than
10 years does not make a reference `State of the art`; it only keeps the category
available. The substantive condition still applies.

The gate exists to separate `State of the art` from `Classic`, which are
otherwise indistinguishable: both describe influential, widely read work, and
age is what tells them apart.

Foundationality is a property of the work itself, so `Classic` precedes
`Background`: a foundational theory is usually general context, and testing it
as context first would classify it as Background and never reach the Classic
step.

Methods still precedes Classic, so a foundational *method* paper is recorded as
Methods. That is intended — when a work's contribution is a technique, the
technique is its function — but it means Classic catches foundational works
only where they are not chiefly a technique.

## Constraints

- Change only the `category` field. Leave every other field, and the reference's
  position, byte-for-byte as they are.
- Where a reference has no `category` field, add one. Match the field's existing
  spacing style in that file.
- Classify from the reference alone. Do not read the user's manuscript, do not
  consult where the user cites the reference, and do not let the user's project
  decide the category. Comparing against the other references is required;
  comparing against the user's writing is not.
- Classify in bibliography order, and expect the result to be independent of it.
  The order of a `.bib` is arbitrary, so if two references of the same kind
  receive different categories, the ordering has leaked into the answer.
- Apply the recency gate against the current year. Do not record a
  classification date.
- Write the category string exactly as listed under `## Categories`.
- Do not create, reorder, merge, split, or delete references.

## Actions

Two passes. The first establishes what the reference set contains; the second
classifies against it.

### Validation

Before writing, confirm each decision against its evidence:

- The reference was read, not inferred from its title.
- The survey was completed, so the decision was made against the whole set.
- The category came from the step that matched, not from a later step's wording.
- `State of the art` was assigned only when $AGE is less than 10.
- `Classic` was reached at step 6, not assigned because the reference is old.
- No reference of the same kind received a different category.
- The value matches one of the seven strings exactly.
- No step depended on the user's manuscript or the user's project.

### Pass one — survey

1. Locate the bibliography file and the reference PDFs.
2. List the references. Report the total, and how many have a usable PDF.
3. Read every available PDF before classifying anything.
4. For each reference, note: the method or argument family it belongs to, which
   references build on it and which it builds on, whether it is current or
   superseded, and whether it reads as foundational.
5. Report the set as groups. Name the families and show which references sit in
   each, so the lineages are visible before any category is assigned.

Keep the survey in your reply. Do not write it to the bibliography file.

### Pass two — classify

### Steps

1. Apply the algorithm to each reference, in order, one at a time.
2. Write each result to that reference's `category` field.
3. Report a table of key, category, and the step that matched. Flag separately
   any reference classified without its PDF, any reference whose evidence was
   ambiguous between two steps, and any pair of alike references that received
   different categories.
4. Show the diff.

## Completion

Show the diff and stop. Do not run `git commit`, `git add -A`, or any other
command that stages or commits changes. Committing the classifications is the
user's decision; an unapproved classification is reverted with `git restore`.
