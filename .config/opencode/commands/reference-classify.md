---
description: Assign one category to each bibliography reference by what it contributes and how the project and the set use it, one record at a time.
---

# Classify References

Assign one category to each reference by what it contributes and how the project and the set use it, and write it to that reference's `category` field.

## Scope

One category per reference. Write `category`, adding it when absent, and nothing else: no other field, no entry order, no key, no type. Three categories are relational and cannot be decided from one reference alone: `Similar work` and `Justification` compare a work with the repository's questions and objectives, and `Classic` compares it with the reference set.

## Inputs

- The bibliography: the single `.bib` in the git top level; zero or several, report and stop.
- `$ARGUMENTS`, a citekey: re-decide that reference even if its category is filled. No argument: process only references whose category is missing or not one of the seven values. If there are none, report no work and stop without reading a source.
- The objectives: the `*.md` files in the repository root. If they state no question or objectives, ask the author once, restate the answer, and use it for the run.
- The source: `<citekey>.pdf`, anywhere in the repository, with its `.txt` beside it. A reference without a PDF is still classified from its record, and reported as classified without a source read. Manuscripts are not inputs.
- The working tree must be clean at the start. Stop and report otherwise.
- Run `pdftotext` in the project container. Discover the one running container; zero or several: stop and ask.

## The text

Read the `.txt`, creating it once with `docker exec <container> pdftotext <pdf> <txt>` if absent; never regenerate. A `.txt` of a few hundred bytes is a scan: report it and classify from the record instead.

## Categories

Methods, Similar work, Justification, State of the art, Classic, Key concepts, Background.

Write these strings exactly, in this capitalisation.

## Decision

Follow in order; the first match wins. The subject of a work is what it presents as its own contribution, quoted from its text; the title and abstract stand in when there is no source.

1. **Methods** — the subject of the work is a method, technique, model, dataset, or analytical procedure.
2. **Similar work** — it addresses the same question or objectives as the repository's.
3. **Justification** — it establishes the importance, scale, or urgency of a problem, or identifies gaps, risks, or unsolved problems that a repository question or objective addresses, fully or partially.
4. **State of the art** — it is under 10 years old and either a review or a synthesis of recent advances, current knowledge, or unresolved debates.
5. **Classic** — its subject is a concept, paradigm, standard, or theory, it is at least 10 years old, and at least three other works in the set cite it.
6. **Key concepts** — its subject is a concept, paradigm, standard, or theory, and it is under 10 years old or cited by fewer than three other works in the set.
7. **Background** — it provides general descriptive or contextual information. This is also the catch-all.

Count citations only for a work that passes the content and the age tests. A work cites another when that work's first author surname and year appear anywhere in its text; check the title when the match is uncertain.

The gate is applied against the current year when a category is written. A filled category is not revisited unless a key is given.

## The survey

Before writing, read every reference that has a source and group the set by lineage: the method or argument family, what each builds on and what builds on it, and whether it is current or superseded. Keep the survey in your reply.

## Steps

1. Read the repository root `*.md` files and restate its question and objectives.
2. Survey the whole set.
3. Take the next reference with no valid category, in file order; if a key was given, take that one.
4. Decide it with the survey and the objectives in view, and write the category where other records place it, else last; verify the entry still parses.
5. Show the key, the title, the category, the step that matched, and the evidence.
6. Stop for approval before the next reference.

A category outside the seven is a contract violation: repair it and report. In a keyed run, a filled category that differs from a fresh decision is asked about, never overwritten.

## Report

For each reference: key, title, category, step, and evidence. Show the diff. Flag any reference classified without a source, any decision ambiguous between two steps, and any pair of alike references that received different categories. At the end, give the whole table, state whether the tree is dirty, and state that you staged and committed nothing.

## Constraints

- Never read a manuscript, and never consult how a manuscript cites a reference: one repository can hold several independent manuscripts. Only the root `*.md` files describe the repository's objectives.
- Do not create, reorder, merge, split, or delete references.
- No `git add`, no `git commit`, no staging.
