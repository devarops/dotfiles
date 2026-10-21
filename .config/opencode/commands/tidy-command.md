---
description: Tidy one command: repair provable defects and stay under 1000 words.
---

# Tidy a Command

Tidy one command per run. Preserve its behavior, repair only provable defects, and keep the file at 1000 words or fewer. The target is `$1`; if `$1` is empty, report the missing argument and stop.

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
- a rule stated twice, or a redundancy that says the same thing;
- a structural error: broken frontmatter, malformed heading, empty section, or malformed table.

Ask one question at a time when two rules contradict, when two commands appear to claim the same job or artifact, or when a judgment call remains. Quote the conflicting passages verbatim. For each option, give a one-line label, the exact replacement text, and a one-sentence justification. Wait for the answer before the next question. Do not ask what the files already settle.

Check the target's name against the AGENTS.md naming rule. Report a violation; never rename the file.

## Overlap

Resolve a confirmed overlap inside the target only. Add or update one durable bullet under OpenCode commands in `AGENTS.md`, stating which command owns the job and which must not repeat it. If the resolution leaves work for another command, add the pending task as described in Scope. Never edit another command.

## Rewrite

Preserve every rule that is not a proven defect. Keep the command's argument interface and behavior. The whole file must end at 1000 words or fewer; never pad. If the rewrite exceeds 1000 words, cut rationale, examples, and over-specified cases first. If the rules still cannot fit, stop before writing and ask which rules may be cut, with options and justifications. After the answer, write the rewrite and report any rule still unresolved.

Keep every optional frontmatter field already present and named in the OpenCode V2 command spec. Add no optional field. Update a present field only when needed. Keep the description to 16 words or fewer; if it is absent, leave it absent.

## Verify

Compare each rule in the numbered inventory file with the rewrite. Every rule must survive or be removed as a proven defect. If a rule is missing, restore it. If it cannot fit, follow the stop-and-ask rule above.

## Write and report

Write once after all answers. If the target is already under 1000 words and has no repairable defect, change nothing and report that result. This is a successful run.

Report the target, the word count before and after, each automatic repair with its evidence, every naming violation, each clarification and answer, any `AGENTS.md` or `TODO.md` change, every unresolved rule and its reason, and whether the tree is dirty. State that nothing was staged or committed.

## Boundaries

- Edit only the target, the durable bullet under OpenCode commands in `AGENTS.md` that records an overlap resolution, and an existing `TODO.md`.
- Never edit another command, rename a file, or add an optional frontmatter field.
- No scratch file inside the repository.
- No staging or committing.
