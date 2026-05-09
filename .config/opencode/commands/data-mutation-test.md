---
name: data-mutation-test
description: Mutate a CSV fixture in a data directory and verify validation (e.g., frictionless) catches it.
---

You are executing the "data mutation testing" workflow. This process ensures that the project's data schemas are robust enough to catch invalid data.

Follow these steps in order:

### Step 1 — Verify clean working tree
Run `git status --porcelain`.
- If it returns output (uncommitted changes), inform the user and STOP.
- If clean, proceed.

### Step 2 — Offer three mutation options
Identify a data directory (typically `tests/data/` or `data/`) and propose exactly three concrete mutations to a CSV file within it.
Each option must specify:
  - which file to mutate,
  - what change to make (old value → new value),
  - why the validation (e.g., Frictionless) *should* catch it (which schema constraint it violates).

**General Examples of Mutations:**
- **Type Violation:** Change a numeric value to a string (e.g., `100` → `"abc"`).
- **Format Violation:** Change a date/time string to an invalid format (e.g., `2023-05-09` → `"09-05-23"`).
- **Constraint Violation:** Change a value to be outside an allowed range or set (e.g., a boolean `0` to `2`, or an enum value to something not in the list).
- **Integrity Violation:** Introduce a duplicate unique ID or remove a required field/column header.

Wait for the user to choose one option before proceeding.

### Step 3 — Apply the chosen mutation
Modify the selected file using the exact change the user picked. Show the diff to confirm.

### Step 4 — Run validation command
Run the project's data validation command. If the project uses Docker, use:
`docker exec <container_name> make check_data` 
*(Note: Replace `<container_name>` with the actual name of the project's container).*

Expect the command to FAIL (non-zero exit code).

- **If it fails as expected**: Run `git restore <data_directory>` to revert the file to its original state, inform the user that the mutation was successfully caught, and STOP.
- **If it does NOT fail** (exit code 0): The schema is too permissive.
  1. Identify the schema definition file (e.g., `datapackage.json` or similar).
  2. Fix the schema to add the appropriate constraint that would catch this mutation.
  3. Run the validation command again.
  4. If it now fails, restore the data file, inform the user, and STOP.
  5. If it still passes, inform the user that further schema tightening is needed.

### Final checks
- Verify `git status --porcelain` shows a clean working tree (only the schema file may remain modified if it was fixed).
- Summarize what was learned about the project's data integrity.
