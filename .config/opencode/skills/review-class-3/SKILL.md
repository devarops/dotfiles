---
name: review-class-3
description: Check reproducibility and artifact integrity in analysis pipelines.
---

## Context:

These repositories implement end-to-end analysis workflows that produce results used in conservation decisions, where correctness and traceability are essential.
They exist to formalize analyses as reproducible pipelines, ensuring results can be regenerated, audited, and trusted over time.
The review focuses on minimizing risks of inconsistency, irreproducibility, and undocumented assumptions that could compromise scientific validity.
Improving structure and clarity supports collaboration, facilitates peer review, and ensures results remain interpretable and defensible.

## Tasks

* Parse all targets defined in the `Makefile`.
* Extract all entries listed in `analyses.json`.
* Normalize naming conventions across both sources to enable accurate comparison.
* Identify targets present in the `Makefile` but missing in `analyses.json`.
* Identify entries present in `analyses.json` but missing in the `Makefile`.
* Flag all inconsistencies and classify them (e.g., missing, extra, mismatched).
* Propose exact additions or removals required to achieve full alignment between `Makefile` and `analyses.json`.
* Verify that all declared artifacts in `analyses.json` are actually produced by the corresponding `Makefile` targets.
* Ensure a strict one-to-one mapping between declared artifacts and generated outputs (no missing or extra outputs).
* Validate that the pipeline is reproducible: identical inputs and configuration produce identical outputs.
* Verify that configuration is centralized and not duplicated or fragmented across scripts and files.
* Preserve original formatting and conventions when suggesting fixes to `Makefile` or `analyses.json`.
* Avoid modifying unrelated content when proposing changes.
* Produce a final reconciled view of `Makefile` targets and `analyses.json` entries, including recommended changes.
* Review `README.md` for accuracy and clarity for academic users.
* Review `AGENTS.md` for accuracy and clarity for data analysts.
