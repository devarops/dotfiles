---
description: Reconcile the backlog and API assumptions with the live public API.
---

# Reconcile Backlog

Probe the live public API, update the client's API assumptions and backlog in `TODO.md`, and refresh the spec and test skip reasons. Do not stage or commit.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- The target is `<root>/TODO.md`; it must exist. The targets are `TODO.md`, `specs/`, and `tests/` when they exist. Each must be clean: `git status --porcelain -- <path>` prints nothing. If one is dirty, report and stop.
- Fetch `http://recurrator/api/openapi.json`. If it is unreachable or not JSON, report and stop without writing.
- Never read the backend source tree. Never stage or commit.

## Sources

- **Live contract.** The public base is `http://recurrator/api/`; its OpenAPI document at `http://recurrator/api/openapi.json` decides what is shipped and outranks a backend criterion.
- **Safe GETs.** Call only GET operations the OpenAPI reports, with the parameters the assumption rows name. Do not pass `csv` or `contexts_csv`; use the public default data. Never call the task due read with exactly one `context`, because it applies WIP and writes `skip_count`/`skip_date`; zero or several contexts are read-only. A 404 is absence; a 5xx, timeout, or non-JSON is unverified.
- **Backend criteria.** Read the non-skipped criteria under `https://github.com/devarops/recurrator/tree/develop/specs`. Use a shallow clone to `/tmp/opencode/recurrator-api` on branch `develop`, or `gh api`; read `specs/*.spec.toml` and ignore a `[[criteria]]` block with `skip =`. If the fetch fails, mark semantic rows unverified and continue.
- **Current repo.** Read `TODO.md`, `specs/*.spec.toml`, `tests/`, and every tracked source file that contains `/api/`.

## Inventory

Maintain `## API assumptions` in `TODO.md` as a table with these columns: Assumption, Probe, Expected, Observed, Status, Used by.

- `Probe` names an OpenAPI operation or field, a safe GET, or a backend criterion. `Expected` is what the client assumes; `Observed` is what the run found.
- `Status` is `holds`, `missing`, `changed`, or `unverified`. A route or field absent from the OpenAPI or answered with 404 is `missing`; a route or field present but returning a different shape, value, or status is `changed`; a probe that cannot run is `unverified`. A non-skipped backend criterion supports `holds`; a skipped or absent criterion makes a semantic row `missing`; a live result that contradicts a non-skipped criterion is `changed`.
- `Used by` lists the item titles the assumption affects.
- Re-probe every row. Add a row for every API fact the repo references but the table lacks. Keep a row no item uses and write `obsolete` in its `Used by` cell; do not delete it.
- If the section is absent, create it and seed it from the referenced facts.

## Classify

Read the previous table before rewriting it, so the report can name the deltas. The item table has these columns: Item, Source, State, Evidence. `Source` is the spec path or test node; `Evidence` is the probe result or missing artifact that decided the state.

List every `TODO.md` bullet and every skipped criterion (`skip =` in a spec) and skipped test (`@pytest.mark.skip` or `{ skip: ... }`) that no bullet owns. A bullet owns the criteria and tests its `Test:` line names; when it names none, the bullet and the criterion or test are separate rows. Report a bullet whose title matches a spec but whose `Test:` line is missing.

Give each item one state:

- `ready` — every linked assumption holds and frontend work remains.
- `waiting` — a linked assumption is `missing`; the API has not shipped the feature.
- `stale` — a linked assumption is `changed`; the API invalidated it. Stale wins over every other state.
- `frontend-only` — the item links to no assumption.
- An item with several assumptions takes the worst state in the order stale, waiting, ready, frontend-only.
- An `unverified` assumption leaves the item's previous state unchanged and goes in the report.

Derive the counts from the table and keep a marker: `Last changed <date> · contract <sha>`, where `<sha>` hashes the OpenAPI document. Update the marker when the hash or a row changes.

## Write

Write without asking: the assumptions table, the item table, the counts and marker, and the spec and test skip reasons.

Rewrite only a skip reason's text to name the current cause. If the blocker is gone, use `Not implemented: <the remaining frontend work>`. Never remove a `skip`. Never edit a test body. Write no other file.

## Report

Report, in this order:

1. The contract marker and the check time.
2. Newly unblocked items: was `waiting`, now `ready`.
3. Items still `waiting`, with the missing assumption.
4. Newly `stale` assumptions and their `Used by` items.
5. `frontend-only` items.
6. `unverified` rows and the source that failed.
7. `obsolete` and unlinked rows.
8. Backend criteria that disagree with the live OpenAPI, as an inconsistency: a non-skipped criterion names a route or field the live API lacks, or a live route has no active criterion.
9. The files written, and that nothing was staged or committed.

## Idempotency

- The durable actions are the `TODO.md` write and the skip-reason writes.
- Their precondition is a clean target and content that differs. After the write, a second run with the same OpenAPI, GET results, and backend criteria reports `current` and writes nothing.
- If the OpenAPI is unreachable, write nothing.
