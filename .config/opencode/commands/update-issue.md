---
description: $1: issue number or URL. Reconcile one GitHub issue around one next action, open and closed lists, and a dated changelog.
---

# Update an Issue

Reconcile one GitHub issue: one next action, an open backlog, a closed history, and a dated changelog.
If `$1` is empty, report the missing argument and stop.

## Gate

- `$1` is an issue number or a GitHub issue URL.
- A URL supplies repository and number; a number defaults to `IslasGECI/kanban`.
- `gh issue view` must succeed and the issue must be unlocked; otherwise report and stop.
- Read `~/.config/opencode/next-action-checks.md`; if it is missing, report and stop.
- Never stage or commit.

## Read and evidence

Read the body, comments, labels, state, and linked artifacts with `gh issue view <number> --repo <owner/repo> --comments --json title,body,comments,labels,state`.
Fetch each URL that bears on a verdict; search `$HOME/repositorios` and GitHub for commits, pull requests, files, and issues.
Read <https://islas.dev/guia_de_estilo/prosa>.
A verdict needs a file, commit, merged pull request, issue state, or linked artifact.
When the record is silent, ask one question at a time with a recommended answer and a one-line justification.
Record an answer absent from the record as `Según <nombre>, <fecha>: <claim>.` in the issue's language.
Give each item and goal one verdict: Delivered, Superseded, Moved, Removed, or Pending.
Name the replacement or destination for Superseded and Moved; Removed lives only in the comment; Pending goes to line 1 or `## Open`.
Do not mark a negative as delivered; ask. One item, one place.

## Next action

Line 1 alone gets the four checks in `~/.config/opencode/next-action-checks.md`.
When a line is needed, the user names it. Apply the checks in order; report the first failure, ask one question, propose wording, and wait for approval of the exact string.
Never repair silently; preserve a valid line 1 and ask only when it is missing, done, or fails a check.

## Body

Write in the issue's language. Use `Context`, `Open`, `Closed` in English and `Contexto`, `Pendientes`, `Terminado` in Spanish.
Line 1 is `- [ ] <next action>. Test: <done>`, or `Prueba:` in Spanish.

```markdown
- [ ] <next action>. Test: <done>

## Context
<free structure: what and why, material, references>

## Open
- [ ] <open item that is not the next action>

## Closed
- [x] <delivered item>
- [x] <superseded item> (sustituido)
- [x] <moved item> (movido)
```

Start with line 1, no leading rule; omit empty sections; preserve the existing `## Context` structure; keep each list's order.
Delivered items are plain; superseded and moved get the short tag in the issue's language; removed items live only in the comment.
Keep the title unless it contradicts the goal; report a proposed title; use active voice, short sentences, and English technical terms.

## Lifecycle and destinations

When line 1 is done, move it to `## Closed`; ask for the new line 1, promoting from `## Open` or naming a new one.
When a valid line 1 is replaced, move the old one to `## Open` if still open, or `## Closed` if done.
Close only when there is no line 1, `## Open` is empty, every leftover has a destination or removal record, and the user approves; use `--reason completed` for `Completed` or `--reason "not planned"` for `Abandoned/Obsolete`.
Reopen only when evidence shows active work or an unmet goal, the user approves, and a valid line 1 is named.
For each item leaving the issue, search first for an existing destination: a new issue, a `TODO.md` item, a recurrator task in `$HOME/.config/recurrator/tasks.csv`, a wiki page or blog post, or an explicit "no hacer".
Link an existing destination instead of duplicating it; read a file destination and match its structure.
For a wiki page or blog post, create the issue or `TODO.md` item that names it; do not write its prose.

## Status

Set one `Status:` label, in this order:

1. No line 1 and no `## Open`: `Completed` if the goal was achieved; `Abandoned/Obsolete` if it was dropped.
2. Goal unclear or contradicted: `Respecification Needed`.
3. Line 1 is a bounded wait: `Blocked`.
4. Line 1 is review or approval: `Review Needed`.
5. Line 1 shows started work: `Work In Progress`.
6. Otherwise: `Available`.

Remove every other `Status:` label; leave non-status labels alone.

## Changelog and approval

Append one `## YYYY-MM-DD` comment per run with one bullet per event: created; closed as delivered, superseded, or moved; removed; reopened; next action changed; status changed.
Use the issue's language; include the evidence or attestation, the destination for superseded and moved items, and the reason for removed items. Link external artifacts. Write no comment when nothing changed.
Present one draft with the full body, the changelog comment, the status label, every destination and its exact write, and the close or reopen.
The next-action line needs its own approval of the exact string before the draft.
Wait; apply edits and present again. Write only the draft the user approves in its presented form.

## Write

Update the body with `gh issue edit --body-file`; post the comment with `gh issue comment --body-file`; set the label with `--add-label` and `--remove-label`; create or update each destination; close or reopen last.
Read the issue back and verify the body, comment, label, state, and destinations.
Report the issue, verdicts, next action and checks, label, comment, destinations, state changes, files, and verification; state that nothing was staged or committed.

## Idempotency

Each durable action names its precondition:

- Line 1: the computed action differs; after, it matches.
- Open or Closed: an item's presence or tag differs; after, it matches.
- Context: a material fact differs; after, it matches.
- Comment: an event is absent; after, it is present.
- Label: the computed label is not the only `Status:` label; after, it is.
- Destination: none exists; after, it exists.
- Close or reopen: the Lifecycle conditions hold; after, the state changes.

A run with no new fact and no approved state change writes nothing; report "sin cambios" and stop.
