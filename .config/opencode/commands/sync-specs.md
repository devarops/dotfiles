---
description: Route each TODO item to its verification home and empty the backlog.
---

# Sync Specs

Read `~/.config/opencode/documentation-contract.md` and follow it. If it cannot be read, report and stop.

## Preconditions

- Resolve `<root>` with `git rev-parse --show-toplevel`; if it fails, report and stop.
- If `TODO.md` is absent, report and stop.
- The targets are `TODO.md`, `specs/`, and `tests/` when they exist. Each must be clean: `git status --porcelain -- <path>` prints nothing. Do not require the rest of the tree to be clean.
- Read `AGENTS.md` for the public interface. If it is absent or lacks the definition, report the gap and stop; `sync-agents` owns it.
- Read `specs/*.spec.toml`, `tests/test_*.py`, `tests/printer/print.py`, and `tests/printer/approved/` when they exist. Route to the homes that exist; never create a harness.

## Classify

For each `TODO.md` item, choose one disposition:

- **Acceptance** — behavior observable through the public interface: a criterion in `specs/*.spec.toml`.
- **Unit** — behavior below the public interface: a skipped unit test in `tests/test_*.py`, outside `tests/test_acceptance_*.py`, marked with the runner's skip and a reason.
- **Visual** — appearance only: a capture scenario in `tests/printer/print.py`. Never write `approved/`; the approval flow records the baseline.
- **Keep** — not behavior, not ready, or no home exists.

An item is ready when it states one observable outcome and every value or relation the artifact needs is stated or derivable from the repo. Test mechanics — file, imports, fixtures — may be invented. An item with several outcomes splits into several artifacts; ask when the split is ambiguous.

## Reconcile

Treat a checklist item and its `##` section as one unit. When the whole item goes, both go; when details remain, keep the section with the remaining details. For each ready item in file order:

- **Covered** by a criterion or test: delete the behavior; keep any implementation detail until the covering artifact's verification passes.
- **Not covered**: write the artifact, matching an existing spec or test by subject. Create `specs/<slug>.spec.toml` or `tests/test_<feature>.py` only when nothing fits; ask when two fit. A criterion names exactly one verify command. A skipped test's reason names its blocker. Then delete the behavior; keep any implementation detail.
- **Implementation detail** whose covering artifact's verification passes: delete it. Before it passes, keep it. Ask when the covering artifact is ambiguous.
- **Group or shared blocker**: keep one two-line item whose `Test:` line names the nodes and the blocker; never restate behavior.
- **Not ready**: leave it and record the missing decision.

Never rewrite an existing criterion or test. Never resolve a contradiction.

## Contradictions

Compare every item with the criteria and skipped tests it would match. A contradiction is a conflict in behavior, not a wording difference. Collect it; leave both sides unchanged. Captures are out of scope; `ui-approve` owns visual contradictions.

## Verify

Run `docker exec ${PWD##*/}_dev make tests` and, when `specs/` exists, `docker exec ${PWD##*/}_dev make verify`, from `<root>`. When the run writes a capture scenario, also run `docker exec ${PWD##*/}_dev make print`. If the container is missing, report and stop. If a target is missing, skip it and report. On a collection, import, syntax, parse, or render error, stop and leave the writes for inspection. Do not repair.

## Report

Report, in this order:

1. Items homed, each with its artifact: spec path and criterion, test path and node, or capture scenario.
2. Items deleted, with why: covered, duplicated, or details whose covering artifact passes.
3. Pointers kept, with their nodes and blocker.
4. Items left, each with the missing decision.
5. Verification results.

Then list the contradictions, numbered under `## Contradictions`, each with the item, the artifact, and the conflict. End with: `Run /iterate-quickfix-list on this list.`

Do not stage or commit.

## Idempotency

- The durable actions are the artifact writes and the `TODO.md` deletions.
- An artifact write has the precondition that no criterion or test covers the item; after the write, one does, so a second run deletes instead.
- A deletion has the precondition that the item is covered, duplicated, or a detail whose covering artifact passes; after it, the item is gone.
- Contradictions are report-only and remain, so a second run lists the same ones and writes nothing.
- When nothing is ready and no contradiction exists, a second run reports nothing to do and stops without writing.
