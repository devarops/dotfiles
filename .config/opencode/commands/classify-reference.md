---
description: Classify scientific references by their function in the project.
---

Assign exactly one category to each reference using a deterministic decision process.
Follow the decision algorithm to classify references based on their primary function in the context of your project.
This is a classification algorithm for scientific references.

## Categories

- Methods
- Key concepts
- Similar work
- State of the art
- Justification
- Background
- Classic

---

## Core Principle

Classify based on the **primary function of the reference in this project**, not its general content.

---

## Decision Algorithm

Follow this sequence **in order**. Stop at the first condition that evaluates to true.

```
INPUT: reference R, context of use C

STEP 1 — Methods
IF R is cited to describe, justify, or implement a technique, model, dataset, or analytical procedure
THEN classify as METHODS
EXIT

STEP 2 — Key Concepts
IF R is cited to define a concept, framework, variable, or theoretical construct
THEN classify as KEY CONCEPTS
EXIT

STEP 3 — Similar Work
IF R is directly comparable to your study (same question, system, species, or methodology)
AND is used for comparison, benchmarking, or contrast
THEN classify as SIMILAR WORK
EXIT

STEP 4 — State of the Art
IF R synthesizes or represents recent advances, current knowledge, or unresolved debates
AND is used to describe the research frontier
THEN classify as STATE OF THE ART
EXIT

STEP 5 — Justification
IF R is used to argue why the study is necessary
(e.g., highlights gaps, risks, importance, or unresolved problems)
THEN classify as JUSTIFICATION
EXIT

STEP 6 — Background
IF R provides general descriptive or contextual information
(e.g., species, region, system, historical overview)
AND is not central to argument or comparison
THEN classify as BACKGROUND
EXIT

STEP 7 — Classic
IF R is a foundational or historically influential work
that established widely used theories, methods, or paradigms
THEN classify as CLASSIC
EXIT

STEP 8 — Fallback Rule
IF multiple categories apply:
    SELECT the category that best matches the *reason it is cited in this specific context*
IF none clearly apply:
    DEFAULT to BACKGROUND
```

## Additional Constraints

* Assign **only one category per citation instance** (not per paper globally).
* The same paper may receive **different categories in different contexts**.
* Prefer **functional classification** over content-based classification.



