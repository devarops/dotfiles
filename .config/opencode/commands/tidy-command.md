---
description: $1: command name. Tidy the command $1 by repairing defects, generalizing over-specific rules, and staying under 1000 words.
---

# Tidy a Command

Tidy one command per run. Preserve its behavior except for an approved generalization. Repair provable defects, check idempotency and convergence, and keep the file at 1000 words or fewer. The target is `$1`; if `$1` is empty, report the missing argument and stop.

## Gate

The current repository must be clean. Run `git status --porcelain`; if it prints anything, report and stop. The target must be a command file in this repository; if it is absent, report and stop. Never stage or commit.

## Scope

Edit the target only. When an overlap, a cross-command duplication, or any other fix would require changing another command, leave that command alone. If `TODO.md` exists, read it and add one pending task describing the change, respecting its structure and skipping duplicates. If `TODO.md` is absent, report the task. Never edit another command.

## Read

Read the target, `AGENTS.md`, every command in the commands directory, and the last eight commits (`git log --patch --max-count 8`). Use the commits to understand why a rule exists; the current files decide every conflict.

## Inventory

Before rewriting, write every behavior-changing rule to a unique temp file under `/tmp/opencode`. Use `mktemp /tmp/opencode/tidy-command-XXXXXX`. This is the rule inventory. A rule is a gate, order, required check, output, prohibition, or scope boundary. Leave out rationale, examples, and descriptions. Number each rule in the target's own words. Delete it when the run ends successfully, including a no-op; if the run stops, keep it and report its path.

## Audit

Repair without asking:

- a reference to a file, command, or path that is absent, when the check proves it;
- a rule stated twice, a redundancy, or a specific rule that a general rule subsumes (see
  Generalize);
- a structural error: broken frontmatter, malformed heading, empty section, or malformed table.

Check congruence with the other commands: shared terms, markers, conventions, and rules. Repair the target's term or rule when the other commands have clearly replaced it; ask when the conflict is a choice.

Ask one question at a time when two rules contradict, when two commands appear to claim the same job or artifact, or when a judgment call remains. Quote the conflicting passages verbatim. For each option, give a one-line label, the exact replacement text, and a one-sentence justification. Wait for the answer before the next question. Do not ask what the files already settle.

Check the target's name against the AGENTS.md naming rule. Report a violation; never rename the file.

## Generalize

A specific rule names a case, path, value, or exception; a general rule states the class.
Generalization by omission removes the specific and leaves the general. Test subsumption by
deleting the specific: if no case it decided would now be decided differently, the general
rule subsumes it. Remove it without asking and record the general rule. Silence is neither
assertion nor negation, so do not add the removed rule's opposite.

A removal that changes a case is a question, not an automatic repair. When the rewrite exceeds
1000 words, offer keep, remove and rely on the general rule, or broaden the general rule;
state the changed outcome. When no general rule exists, propose one in the same question.

When a repair would add a case, generalize first; add the case only after the author rejects
generalization.

## Idempotency and convergence

For each durable action, assume the work is already done unless the target's instructions prove otherwise. The action must have a named precondition tied to the unit of work the target owns. Examine writes, appends, creates, deletes, renames, commits, and external changes. A vague condition is not evidence. After the action, the precondition must be false; a target with no durable effects passes. Ask about an action with no named precondition, or one that leaves its precondition true, offering guard options in the Audit format.

## Overlap

Resolve a confirmed overlap inside the target only. Add or update one durable bullet under OpenCode commands in `AGENTS.md`, stating which command owns the job and which must not repeat it. Add it when absent, update it only when the resolution changed, and leave it otherwise. If it already records this boundary, do not ask again. If the resolution leaves work for another command, add the pending task as described in Scope. Never edit another command.

## Rewrite

Preserve every general rule and every specific rule that is not subsumed or approved for removal. Keep the command's argument interface; preserve its behavior except for an approved generalization. The whole file must end at 1000 words or fewer; never pad. If the rewrite exceeds 1000 words, apply Generalize first: remove subsumed specifics and ask about each behavior-changing removal. Then cut rationale and examples. If the rules still cannot fit, stop before writing and ask which general rules may be cut, with options and justifications. After the answer, write the rewrite and report any rule still unresolved.

Keep every optional frontmatter field already present and named in the OpenCode V2 command spec. Add no optional field. Update a present field only when needed. When you edit the description, use function-signature style: start with each argument as `$1: <type>.`, then the action; omit the parameter line when there is no argument. Keep it to 20 words or fewer. If it is absent, leave it absent.

## Verify

Compare each rule in the numbered inventory file with the rewrite. Every rule must survive, be removed as a proven defect, or be generalized with the surviving general rule named and the no-case-changes proof recorded. If a rule is missing, restore it. If it cannot fit, follow the stop-and-ask rule above. Then rerun the audit and the convergence check on the rewrite; it must pass with no repairable defect or convergence gap.

## Write and report

Write once after all answers. If the target is already under 1000 words and has no repairable defect or convergence gap, change nothing and report that result. This is a successful run.

Report the target, the word count before and after, each automatic repair with its evidence, every naming violation, the idempotency and convergence verdict, each clarification and answer, any `AGENTS.md` or `TODO.md` change, every unresolved rule and its reason, and whether the tree is dirty. For each generalization, name the specific rule removed, the general rule kept, the case test, and any approved behavior change. State that nothing was staged or committed.

## Boundaries

- Edit only the target, the durable bullet under OpenCode commands in `AGENTS.md` that records an overlap resolution, and an existing `TODO.md`.
- Never edit another command, rename a file, or add an optional frontmatter field.
- No scratch file inside the repository.
- No staging or committing.
