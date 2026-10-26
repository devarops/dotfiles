---
description: $1: raw text. Infer the story and write OUTLINE.md with the arc's outline items.
---

# Phase 0: Story Outline

You reconstruct the story a free-written draft tells, confirm it, and state the document's
structure. The outline anchors the arc; it does not define paragraphs.

## Role and reader mode

This command is always external-reader. Read `~/.config/opencode/prose-options.md` and follow
it.

## Inputs

- The raw text is `$1`, a stream-of-consciousness free-write with one sentence per line.
- The outline is written to `OUTLINE.md`, beside `$1`.
- If `$1` is missing, ask for it and stop.

## The standard

- The standard is Schimel, *Writing Science*,
  `~/repositorios/wiki/raw/schimel2012writing.txt`. If it is missing or unreadable, stop.
  Never regenerate it.
- Read chapters 2 Science Writing as Storytelling, 3 Making a Story Sticky, 4 Story Structure, 5 The Opening, 6 The Funnel: Connecting O and C, 7 The Challenge, 8 Action, 9 The Resolution, and 10 Internal Structure.
- Do not use chapter 11 or any paragraph rule. Phase 0 knows nothing about paragraphs.
- For a judgment call, follow Schimel first.

## Constraints

Permitted: read the raw text; present story candidates; ask questions; write `OUTLINE.md`.

Forbidden: new ideas, sentences, or propositions; paraphrasing; writing the paper's prose,
or a heading or title for it; editing `$1`.

- The story and its frame stay in the author's words, except the fixed OCAR shape: quote `$1`
  or let the author supply them.
- **`# STORY` states structure and claims, not evidence.** It may name the case, not numbers,
  citations, formulas, instrument names, or site designations. If changing a datum would force
  an edit here, the line is too specific.
- **The story shape is always OCAR.** LDR and ABDCE are out of scope.
- Content that fits no part of the story stays in `$1`.
- **Assume a clear story and no structure.** Infer it; do not change or complete it.
- **The map is structural.** Derive section headings and outline items from the confirmed
  story and the OCAR mapping; let the author approve or edit them.
- **An outline item is terse.** It states a label, a job, a question, and a local arc role. It
  may not name a fact, number, citation, source, example, definition, sentence order, or
  content inventory. Keep the job and question to roughly 30 words; rewrite a longer item.
- **An outline item never defines paragraphs.** It groups any number of paragraphs that serve
  its job and question.

## The outline file

`OUTLINE.md` is nested Markdown:

    # STORY

    - Audience — <who reads it>
    - Story shape — OCAR
    - Hourglass — <how wide the opening is and how local the resolution is>
    - OPENING — <author's opening summary>
    - CHALLENGE — <author's challenge summary>
    - ACTION — <author's action summary>
    - RESOLUTION — <author's resolution summary>

    ## <SECTION> — <OCAR part>

    Job: <what the section must do>
    Question: <what it must answer>

    - <Label> — Job: <what the item must do>; Question: <what it must answer>; Arc: <opening|development|resolution>

- `# STORY` records audience, story shape, and hourglass, then states the four OCAR parts in
  order.
- `## <SECTION> — <OCAR part>` maps each section (Introduction, Methods, Results, Discussion,
  Conclusion) to its OCAR role (4.3). A section may appear under more than one part.
- `- <Label> — Job: ...; Question: ...; Arc: ...` is one outline item, in document order. The
  label is a short stable handle; number within the section if it carries a number. The arc
  role is the item's place in the section's arc: opening, development, or resolution.
- No subsections, paragraph slots, or paragraph count. Nesting runs Story, Section, Outline
  item.

Phase 0 writes zero `<!-- ... -->` comments, zero `[[ ... ]]` annotations, and zero `XXX`
placeholders into `OUTLINE.md`. It outputs only clean Markdown.

## Actions

### Pre-flight

- The tree has no changes except `OUTLINE.md`; otherwise ask the author to commit or stash.
- `$1` exists, is readable, is text, ends in `.md`, and has every sentence on its own line.
- `OUTLINE.md` is absent or empty. If non-empty, notify the author and stop: this phase
  creates the outline once.
- If a check fails, notify the author and stop.

### Step 1 — Confirm the story

Read the whole raw text and infer the story. Build whole-story candidates, each a short
collage of the author's own sentences stating one coherent arc, phrased as "this is the story
you may be telling"; add no words. Label each with its OCAR reading.

Present them with the direction: target, OCAR key terms, and choice. Ask which story the
author is telling. Ask only what the draft cannot settle, one question at a time.
On rejection, build new candidates from the author's words. Repeat until one story is
confirmed. Nothing is written until then.

Ask the author for the audience and the hourglass; the story shape is always OCAR.

### Step 2 — Map the story

1. Name the four OCAR parts and place the paper's sections under them (4.3).
2. Give each section a `Job:` and a `Question:` derived from the confirmed story; present
   them for approval or edits.
3. Derive the outline items from the confirmed story, section by section: group the author's
   own sequence into item-sized jobs. Give each item a label, a job, a question, and a local
   arc role: opening, development, or resolution. Do not define paragraphs or count them.

Present the full sequence and explain it; wait for one approval or edit; do not interview
per item.

### Step 3 — Write the file

On approval, check each item against the terseness rule, then write `OUTLINE.md`: STORY, each
section heading with Job and Question, and the item bullets in order.

Do not stage or commit; those decisions are the author's.

## Completion

Report the confirmed story, the audience, the hourglass, the OCAR parts, sections, outline
items, and the questions asked. Phase 1 requires a clean tree, so the author must commit
`OUTLINE.md` before running it.
