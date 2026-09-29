---
description: Resolve annotations by interviewing the author, adding content to gaps or rewriting text the annotation points at.
---

# Phase 2: Resolve Annotations

- The target Markdown file is provided as `$ARGUMENTS`.
- An annotation is any `[[ ]]` or `XXX` marker. Every annotation requires the
  author's input. None is resolved without it.

## The book

- The text is `~/repositorios/wiki/raw/schimel2012writing.pdf`, derived to
  `~/repositorios/wiki/raw/schimel2012writing.txt`. If the PDF is missing or
  unreadable, stop. Never check against a book you have not read.
- The `.txt` holds one line per paragraph, with running heads, page numbers, and
  blank pages removed. Create it once if it is missing. Never regenerate it.

  ```bash
  set -euo pipefail
  PDF=~/repositorios/wiki/raw/schimel2012writing.pdf
  TXT=~/repositorios/wiki/raw/schimel2012writing.txt
  [ -r "$PDF" ] || { echo "missing: $PDF" >&2; exit 1; }
  if [ ! -s "$TXT" ]; then
    pdftotext "$PDF" /tmp/schimel.raw.txt 2>/dev/null
    python3 - /tmp/schimel.raw.txt "$TXT" <<'PY'
import re, sys

HEADS = {"Writing in Science", "Science Writing as Storytelling",
         "Making a Story Sticky", "Story Structure", "The Opening",
         "The Funnel: Connecting O and C", "The Challenge", "Action",
         "The Resolution", "Internal Structure", "Paragraphs", "Sentences",
         "Flow", "Energizing Writing", "Words", "Condensing",
         "Putting it All Together: Real Editing", "Dealing with Limitations",
         "Writing Global Science", "Writing for the Public"}
PAGE = re.compile(r"^\d{1,3}$")
BLANK = re.compile(r"^(This page intentionally left blank|Contents|Index)$")
HEAD = re.compile(r"^(?:\d+\.\d+)*\.? ")
EXAMPLE = re.compile(r"^(Example|Figure|\d+\. )")
LOWER = re.compile("^[a-z(“'–—]")

out, block = [], []
for raw in open(sys.argv[1], encoding="utf-8").read().replace("­", "").split("\n"):
    s = raw.strip()
    if not s or PAGE.match(s) or s in HEADS or BLANK.match(s):
        if block: out.append(" ".join(block)); block = []
        continue
    if HEAD.match(s):
        if block: out.append(" ".join(block)); block = []
        out.append(s)
        continue
    if EXAMPLE.match(s) or (block and LOWER.match(raw)):
        block.append(s)
        continue
    if block: out.append(" ".join(block))
    block = [s]
if block: out.append(" ".join(block))
open(sys.argv[2], "w", encoding="utf-8").write("\n".join(out) + "\n")
PY
  rm -f /tmp/schimel.raw.txt
  fi
  ```

- Section numbers survive extraction, so cite them as locators. Section 4.1 holds
  the four story structures, 10 the nesting of arcs, 11 the paragraph types, 12 the
  sentence roles, and 13 flow.

  ```bash
  TXT=~/repositorios/wiki/raw/schimel2012writing.txt
  grep -n '^11\.' "$TXT"   # every paragraph-type section, by line
  grep -n '^12\.' "$TXT"   # every sentence section, by line
  ```

- Open the section in `$TXT` before you act on it, and read the examples with it.
  The book's examples decide cases the prose leaves open; a rule you have only read
  in summary has not been read.
- These phases target a peer-reviewed journal article, so the structure is OCAR at
  the paper's level. Schimel offers ABDCE, LD, and LDR there too, and they are not
  used. SUCCES (chapter 3) and word choice by etymology (15.3) are likewise out of
  scope: the second is a register change, and these phases preserve the author's
  voice.

## Two kinds of annotation

- **Add content.** The annotation marks a gap. The author's answer is written in
  place of the annotation.
- **Rewrite content.** The annotation points at existing text. The author's answer
  replaces that text, and the annotation is removed with it.

## Paragraph roles

A paragraph is made of three roles: the **opening** sets the stage, the
**development** carries the event, the **resolution** resolves by making the
paragraph's point. A paragraph must have an opening and a resolution, and the two
may be the same sentence.

An unresolved annotation marks a missing element at its position. Before asking,
infer the paragraph's type from the sentences around it, because the type decides
what the answer must be:

- **TS-D** — a one-sentence lead that both sets the stage and makes the point. A
  gap before any development is a missing point-and-opening; a gap after
  development is a missing resolution.
- **LD** — a lead of several sentences that ends on the point. The point sits early
  and everything after develops it.
- **LDR** — a lead that argues, development, then a closing synthesis. The point
  sits in the last sentence.
- **OCAR** — an opening that sets the stage without arguing, development, then a
  closing synthesis. The point sits in the last sentence.

Schimel treats these as a spectrum, not a set of categories. Report the dominant
position of the point; a paragraph may sit anywhere between point-first and
point-last, and some are hard to classify. What matters is that the paragraph
opens, resolves by making a point, and carries exactly one point.

- Identify which element the annotation occupies before asking, and frame the
  question for it.
- An answer must serve that element. An opening sets the stage with something the
  reader already holds; a resolution states the outcome, and in a point-last
  paragraph it synthesises what came before into the paragraph's point.
- If the answer does not serve the element, ask the author to rewrite. Do not
  accept it and do not restructure.
- After insertion the paragraph must still carry exactly one point, with its
  opening and resolution in the positions its type calls for, and nothing may be
  added outside the confirmed target.

## Authorship

The author must write every word. The agent prompts and guides but never writes the
sentence, because authorship and accountability belong to the author.

- The agent never writes a candidate sentence. All agent output is meta-language: a
  direction, key terms, and a justification.
- An option is a direction plus key terms, never a grammatical sentence. Its key terms
  must add at least one fact or distinction absent from the annotation and the question.
- An answer is rejected as too similar when it shares a run of consecutive words with
  an option, the question, or the agent's explanation. Rejection means the author
  ratified your phrasing rather than writing it, which defeats the purpose.
- On rejection, ask the author to rewrite, and refresh the direction and key terms to
  offer more options. Never supply a sentence. Repeat without a cap.

## Asking

For each annotation found in the file, in order:

- state your reading of the annotation and the exact text you take to be its target;
- name the paragraph element the annotation occupies;
- ask the question that element calls for;
- offer options, each a direction plus key terms, never a sentence;
- wait for the author's input.

Locate the annotation's target as best you can. If it is not found, or is found more
than once, say so and ask the author to confirm which text is meant. Never resolve an
annotation against a target the author has not confirmed. If an annotation names more
than one target, confirm each, and apply one answer to all of them.

Present one annotation at a time. Move to the next only after the author has provided
input for the current one. If the author rejects your recommendation, let them explain
why and try again.

## Applying an answer

- **Add content:** write the answer where the annotation is, replacing the annotation.
- **Rewrite content:** write the answer in place of the confirmed target, and remove
  the annotation.
- Change nothing else.

## What this phase does not do

- Do not generate content. Apply the author's words; do not supply your own.
- Do not write a candidate sentence; keep all agent output in meta-language.
- Do not create new annotations.
- Do not alter, reorder, merge, rephrase, or delete anything outside the confirmed
  target.

## Completion

Report how many annotations were resolved and how many remain. If none were resolved
or none remain, say so and stop. Otherwise leave the unresolved annotations in place,
with their targets quoted, and let the author decide what runs next.

Commit after each pass.
