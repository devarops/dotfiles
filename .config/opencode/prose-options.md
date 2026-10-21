# Prose Options

Shared rules for commands that modify prose. A command that points here reads this file
before acting and follows it.

## Reader modes

Every piece of prose has an intended reader, internal or external to the team.

- An **internal-reader command** modifies internal prose. It may provide more help.
- An **external-reader command** modifies external prose. It guards against
  **dispossession**: the author owns every wording choice.

A command declares its reader mode in its own instructions. If it is always external-reader
or always internal-reader, follow that. If it can be either, determine the intended reader
from the artifact: infer it from the path, title, content, and project context; state the
inference; ask the author to confirm. If it remains unresolved, default to external. A
single artifact with mixed sections is external. A list of separate artifacts uses one mode
for the whole list; if any item is external or the list is mixed, the list is external.

## The external-reader rule

Before interviewing the author about wording, an external-reader command reads
`~/repositorios/wiki/bundle/4a.md` and every `4a.*.md` child concept and states this rule
inline:

> The author writes every word that involves a choice of wording. The command is bounded
> to structure, questions, directions, and deterministic edits. Approving the command's
> phrasing would be ratification, not authorship.

If 4a is missing or unreadable, stop. An internal-reader command does not read 4a or its
children.

## Steps

For each authorship-bearing item, follow the steps the reader mode allows. Mechanical or
deterministic edits are not gated: apply them without asking.

1. **Direction.** Always show a direction plus key terms in meta-language. The direction
   names the target, the problem, and the terms or constraints that decide the replacement.
   It is never a grammatical sentence. It may include safe alternatives. The author writes
   the replacement or chooses a safe alternative. Setup questions and confirmations are not
   directions; this rule governs the item's replacement direction.
2. **Alternatives (internal-reader only).** After the direction, ask:

   > Do you want me to show you alternatives, or would you like to fix it yourself?

   If the author chooses alternatives, show finished artifacts, ready to apply.

External-reader stops after the direction. Internal-reader may use both steps.

## Safe alternatives

A safe alternative uses only the author's existing words, structure, or meta-language. It
does not compose new prose. Story collages, actual mapping choices, and split points are
safe. External-reader may show them because they do not write the author's prose. They must
be distinct from each other: different, complementary, or opposite, never too similar.

## Finished alternatives

A finished alternative is ready-to-apply wording or code. It writes the author's prose.
Only internal-reader offers finished alternatives. Choosing one accepts dispossession.
Show them only after the author asks. Each must be distinct: different, complementary, or
opposite, never too similar.

## The authorship guard

- The direction and key terms stay in meta-language; never write a grammatical sentence.
- Finished alternatives must be distinct from each other; no near-duplicates.
- If the author writes a replacement, reject it as too similar when it shares a long run of
  words with the direction, the key terms, or an alternative. Ask for a rewrite; never
  supply the sentence. Do not reject the author's own source text or a safe alternative.
- Give no recommendation. The author chooses.

## Applying

The author's reply either gives the replacement (direction or self-fix) or selects an
alternative. Apply it to the confirmed target. Change nothing outside that target. Show the
result and how to undo it.

## Command contract

Each command names the actual artifact for its direction step, the safe alternatives it may
show, and, when it has an internal-reader mode, the finished alternatives it may show. If a
command cannot produce a kind, it omits it. The command's own scope still applies.
