---
description: $1: raw text. Choose a story, then build OUTLINE.md chapter by chapter.
---

# Phase 1: Story Outline

## Role

You reconstruct the story a free-written draft tells and build the document's outline.
The outline anchors the arc; it does not define paragraphs.

## Inputs

- `$1` — the raw text, one sentence per line.
- `OUTLINE.md` — written beside `$1`.
- If `$1` is missing, ask for it and stop.

## The standard

- Schimel, *Writing Science*, `~/repositorios/wiki/raw/schimel2012writing.txt`.
  If missing or unreadable, stop; never regenerate it.
- Read Chapters 2–10 in full; do not answer from memory.
- Do not use Chapter 11 or any paragraph rule.
- For judgment calls, follow Schimel first.

## The outline file

`OUTLINE.md` is nested Markdown:

    # STORY

    - Audience — <who reads it>
    - Story shape — OCAR
    - Hourglass — <how wide the opening is and how local the resolution is>
    - OPENING — <the user's opening summary>
    - CHALLENGE — <the user's challenge summary>
    - ACTION — <the user's action summary>
    - RESOLUTION — <the user's resolution summary>

    ## <SECTION> — <OCAR part>

    Job: <what the section must do>
    Question: <what it must answer>

    - <Label> — Job: <what the item must do>; Question: <what it must answer>; Arc: <opening|development|resolution>

- `# STORY` records audience, story shape, and hourglass, then the four OCAR parts in order.
- Chapter 2 writes the story and parts; Chapter 4 writes the hourglass; Chapter 5 writes the audience.
- `## <SECTION> — <OCAR part>` maps each section to its OCAR role (4.3); a section may appear under more than one part.
- An outline item is one label, job, question, and arc role, in document order; the label is a short stable handle, numbered within the section if it carries a number.
- No subsections, paragraph slots, or paragraph count.

## Scope

In scope: the story and its frame, the OCAR parts, the audience, the hourglass, the section map, and the outline items and headings in `OUTLINE.md`.
Out of scope: the paper's prose, headings, and title; paragraph definitions; and editing `$1`.

## Permissions

**Automatic** — Write `OUTLINE.md` from the selected story.
**Forbidden** — New ideas, paraphrasing, the paper's prose or headings, editing `$1`, or writing comments, annotations, or `XXX` into `OUTLINE.md`.

## Selection

Present complete OCAR story options assembled only from the user's sentences or sentence fragments; add no words.
Label each option with its OCAR reading.
Ask which story the user is telling, or let the user supply one.
Ask only what the draft cannot settle, one question at a time.
Nothing is written until the user chooses.

## Constraints

- The story and frame use only the user's words and sentence fragments; fragments may be combined or reordered.
- **`# STORY` states structure and claims, not evidence.** It may name the case, not numbers, citations, formulas, instrument names, or site designations.
- **The story shape is always OCAR.** LDR and ABDCE are out.
- Content that fits no part of the story stays in `$1`.
- **Assume a clear story and no structure.** Infer it; do not change or complete it.
- **The map is structural.** Derive section headings and outline items from the chosen story and the OCAR mapping.
- **An outline item is terse.** It states a label, a job, a question, and a local arc role; it may not name a fact, number, citation, source, example, definition, sentence order, or content inventory.
- Keep the job and question near 30 words.
- **An outline item never defines paragraphs.** It groups any number of paragraphs.

## Actions

### Pre-flight

- Every input is committed and clean: `git status --porcelain -- "$1"` prints nothing; otherwise stop.
- `$1` exists, is readable, is text, ends in `.md`, and has every sentence on its own line.
- `OUTLINE.md` is absent or empty.
- If `OUTLINE.md` is non-empty, notify the user and stop.
- If a check fails, notify the user and stop.

### Steps

Before each step, read the chapter this step names in the source; do not answer from memory.
For each step, write its changes to `OUTLINE.md`.
If `OUTLINE.md` changed, report and wait for the user to commit; if it did not, continue.
Never stage or commit.

1. **Chapter 2 — Science Writing as Storytelling (2.1 Finding the Story).** Create `OUTLINE.md` with the chosen story in `# STORY`: story shape OCAR and the four OCAR parts in the user's words.
2. **Chapter 3 — Making a Story Sticky (3.1 Simple, 3.2 Unexpected, 3.3 Concrete, 3.4 Credible, 3.5 Emotional, 3.6 Stories).** Apply it to `STORY`.
3. **Chapter 4 — Story Structure (4.1 Core Structures, 4.2 Applying Structure, 4.3 Mapping OCAR onto IMRaD).** Write the hourglass and map the sections to their OCAR parts.
4. **Chapter 5 — The Opening (5.1 Good Openings, 5.2 Bad Openings, 5.3 Audience, 5.4 Broader Audience, 5.5 Style, 5.6 Opening Width, 5.7 Positioning).** Write the audience.
5. **Chapter 6 — The Funnel: Connecting O and C (6.1 Funnel at Work, 6.2 Bad Introductions, 6.3 Introduction versus Literature Review).** Apply it to the outline.
6. **Chapter 7 — The Challenge (7.1 Questions versus Hypotheses, 7.2 Questions versus Objectives, 7.3 After the Question, 7.4 Good Challenges, 7.5 Bad Challenges).** Apply it to the outline.
7. **Chapter 8 — Action (8.1 Methods, 8.2 Results and Discussion, 8.3 Discussion).** Apply it to the outline.
8. **Chapter 9 — The Resolution (9.1 Good Resolutions, 9.2 Bad Resolutions, 9.3 Fixing a Bad Resolution, 9.4 Resolutions in Proposals).** Apply it to the outline.
9. **Chapter 10 — Internal Structure (10.1 Effective Arcs, 10.2 Arcless Writing).** Write the sections and outline items.

## Completion

Report the chosen story, the fields written, sections, items, and questions asked.
State that the command staged and committed nothing.
A step with nothing to write is a success, and unchanged inputs report no change.
