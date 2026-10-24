---
description: Rank the bibliography references that can fix one citation, reading each candidate in full and quoting evidence.
---

# Fix Citation

Fix one citation: find its candidates in the bibliography, read each candidate in full,
discard the ones that do not help, and rank the survivors with quoted evidence. Report
only; never edit.

## Scope

One citation target per run: the citation under discussion. Do not edit the manuscript, the
bibliography, or any other file, and do not stage or commit. When the target is not clear
from the session, ask which citation and stop.

## Inputs

- The bibliography.
- The target: the citation under discussion. Read its sentence, its paragraph, and its
  section heading. If the target is a bibliography entry rather than manuscript prose,
  report and stop.
- The sources: `<citekey>.txt` for each shortlisted entry. The working tree may be dirty;
  read it as it is.

## Short list

Read the bibliography in full, every entry and every line.

An entry is a candidate when its subject could bear on the claim in any direction: it
supports, qualifies, contradicts, or documents the sentence. Do not use `category` as
evidence.

Always include every key already cited at the target, whether or not its record looks
related.

## Full texts

Read each shortlisted `.txt` from start to finish.

## Ranking

Order the survivors by, in turn:

1. **Directness** — how directly the passage states the claim's proposition, or, for a
   method or data source, the thing the sentence uses.
2. **Scope match** — same species or taxon, region, period, and method as the claim.
3. **Evidence type** — an empirical result with numbers, then an empirical result without
   numbers, then a review or synthesis, then commentary, policy, or opinion.
4. **Recency** — the newer work first.

Two survivors share a rank only when all four tie; mark the tie.

Label each survivor's relation:

- **supports** — the passage asserts the claim, or the part it covers.
- **qualifies** — the passage holds it under conditions, or covers only part.
- **contradicts** — the passage asserts the contrary or a conflicting result.
- **documents** — the passage describes the method, software, or data the sentence uses.

## Report

Open with the target and the claim:

    Target: <file>:<line> (or "from the session")
    Claim: "<sentence, verbatim>"
    Reading: <one line naming the proposition screened for>

List the survivors, ranked, one block each:

    **1. `citekey` (year) — short title** — supports
    Justification: <one or two sentences: the part of the claim it covers, the scope match, the evidence type>
    Evidence: "<quote>" — `<citekey>.txt:<line>`
    Already cited: <nearest occurrence in the target's file, or a count elsewhere>

Use the strongest passage. If the same source also cuts the other way, quote that too, in
the same format. Show `Already cited` only when it is.

Close with:

- Short list: N entries; discarded: M.
- Current citation: survives at rank R / does not survive / absent from the bibliography /
  none.
- No citation needed: when the sentence states the study's own result, aim, or a definition
  already sourced in the paragraph, say so and why.
- Partial coverage: when no survivor covers the whole claim, name the part each covers.
- Mismatches: when a record field and the source disagree on something the decision used,
  show both values and decide nothing.

## Constraints

- Repair only obvious text-layer glyph errors; change no word.
- Evidence must come from the full text, never from the bibliography record.
- Audit every key already cited at the target, and report each verdict.
