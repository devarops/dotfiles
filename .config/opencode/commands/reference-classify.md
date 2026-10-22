---
description: Assign one functional category to each bibliography reference from the reference set as a whole, one record at a time.
---

# Classify References

Assign one category to each reference by the job it does in the literature, and write it to that reference's `category` field. A category is a property of the reference, not of the manuscript.

## Scope

One category per reference. Write `category`, adding it when absent, and nothing else: no other field, no entry order, no key, no type. Two categories are relational and cannot be decided from one reference alone: `Classic` and `Similar work` compare a work with the reference set, never with the manuscript.

## Inputs

- The bibliography: the single `.bib` in the git top level; zero or several, report and stop.
- `$ARGUMENTS`, a citekey: re-decide that reference even if its category is filled. No argument: process only references whose category is missing or not one of the seven values. If there are none, report no work and stop without reading a source.
- The source: `<citekey>.pdf`, anywhere in the repository, with its `.txt` beside it. A reference without a PDF is still classified from its record, and reported as classified without a source read. The manuscript is not an input.
- The working tree must be clean at the start. Stop and report otherwise.
- Run `pdftotext` in the project container. Discover the one running container; zero or several: stop and ask.

## The text

Read the `.txt`, creating it once with `docker exec <container> pdftotext <pdf> <txt>` if absent; never regenerate. A `.txt` of a few hundred bytes is a scan: report it and classify from the record instead.

## Categories

Methods, Key concepts, Similar work, State of the art, Justification, Classic, Background.

Write these strings exactly, in this capitalisation.

## Decision

Follow in order; the first match wins.

1. **Methods** — the work presents, validates, or implements a technique, model, dataset, or analytical procedure.
2. **Key concepts** — it defines a concept, framework, variable, or theoretical construct.
3. **Similar work** — it addresses the same question, system, species, or methodology as the reference it is compared against.
4. **State of the art** — it is under 10 years old and synthesises recent advances, current knowledge, or unresolved debates.
5. **Justification** — it establishes the importance, scale, or urgency of a problem, or identifies gaps, risks, or unsolved problems.
6. **Classic** — it is foundational or historically influential, has established a widely used theory, method, or paradigm, and is over 10 years old.
7. **Background** — it provides general descriptive or contextual information. This is also the catch-all.

The gate is applied against the current year when a category is written. A filled category is not revisited unless a key is given.

## The survey

Before writing, read every reference that has a source and group the set by lineage: the method or argument family, what each builds on and what builds on it, whether it is current or superseded, and whether it reads as foundational. Keep the survey in your reply.

## Steps

1. Survey the whole set.
2. Take the next reference with no valid category, in file order; if a key was given, take that one.
3. Decide it with the survey in view, and write the category where other records place it, else last; verify the entry still parses.
4. Show the key, the category, the step that matched, and the evidence.
5. Stop for approval before the next reference.

A category outside the seven is a contract violation: repair it and report. In a keyed run, a filled category that differs from a fresh decision is asked about, never overwritten.

## Report

For each reference: key, category, step, and evidence. Show the diff. Flag any reference classified without a source, any decision ambiguous between two steps, and any pair of alike references that received different categories. At the end, give the whole table, state whether the tree is dirty, and state that you staged and committed nothing.

## Constraints

- Never read the manuscript or consult how the manuscript cites the reference.
- Do not create, reorder, merge, split, or delete references.
- No `git add`, no `git commit`, no staging.
