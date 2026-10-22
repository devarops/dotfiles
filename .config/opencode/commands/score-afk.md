---
description: Evaluate the codebase for code smells and assign scores based on adherence to best practices.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.
The goal of this phase is to evaluate the codebase against some quality assurance criteria.

## Code Smells

- **Bloaters**
  Bloaters are code, methods, and classes that have grown to such gargantuan proportions that they are hard to work with.
  Usually these smells do not crop up right away; rather, they accumulate over time as the program evolves (especially when nobody makes an effort to eradicate them).
  - Long Method
  - Large Class
  - Primitive Obsession
  - Long Parameter List
  - Data Clumps

- **Object-Orientation Abusers**
  All these smells are incomplete or incorrect application of object-oriented programming principles.
  - Alternative Classes with Different Interfaces
  - Refused Bequest
  - Switch Statements
  - Temporary Field

- **Change Preventers**
  These smells mean that if you need to change something in one place in your code, you have to make many changes in other places too.
  Program development becomes much more complicated and expensive as a result.
  - Divergent Change
  - Parallel Inheritance Hierarchies
  - Shotgun Surgery

- **Dispensables**
  A dispensable is something pointless and unneeded whose absence would make the code cleaner, more efficient and easier to understand.
  - Comments
  - Duplicate Code
  - Data Class
  - Dead Code
  - Lazy Class
  - Speculative Generality

- **Couplers**
  All the smells in this group contribute to excessive coupling between classes or show what happens if coupling is replaced by excessive delegation.
  - Feature Envy
  - Inappropriate Intimacy
  - Incomplete Library Class
  - Message Chains
  - Middle Man

## Task

- For each code smell, assign a score from 0 to 100 (integer) based on how well the codebase adheres to best practices in that area.
- A score of 0 indicates that the codebase is severely affected by that code smell (0 is the worst).
- A score of 100 indicates that the codebase is completely free of that code smell (100 is the best).
- Read the last row of `score_detail.csv` before writing. If its five score columns already hold values, report those scores and stop without writing.
- Otherwise fill the five empty score columns of that row with the scores you assigned. Never append a row.
- `score_detail.csv` has the columns `sha,reviewer,bloaters,object_orientation_abusers,change_preventers,dispensables,couplers`; ignore `sha` and `reviewer`, which are already filled.
- Validate the file with frictionless goodtables after writing.

