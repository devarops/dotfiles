---
description: Check a Markdown or text document against ASD-STE100 Simplified Technical English and write a compliance report.
---

# Simplify English

Check one document against ASD-STE100 Simplified Technical English (STE) and write a
compliance report beside it.

The document is never modified. The report is never committed.

## Inputs

- The document is `$ARGUMENTS`. It must be one `.md` or `.txt` file.
- If `$ARGUMENTS` is empty, ask for the path. Do not guess it.
- If the path does not exist, cannot be read, or is neither `.md` nor `.txt`, stop and say so.

## The standard

- The specification is `~/repositorios/wiki/raw/ASD-STE100_ISSUE9.pdf` (Issue 9, 2025-01-15).
- If the PDF is missing or unreadable, stop. Never check a document against a standard you have not read.
- The extracted text is `~/repositorios/wiki/raw/ASD-STE100_ISSUE9.txt`.
  Use it when it exists. Never regenerate it.
- If it does not exist, create it once:

  ```bash
  pdftotext -layout ~/repositorios/wiki/raw/ASD-STE100_ISSUE9.pdf \
    ~/repositorios/wiki/raw/ASD-STE100_ISSUE9.txt
  ```

- Every rule, word and example comes from that text file. Do not answer from memory.
  The rules changed in Issue 9, and rules that existed in earlier issues are gone.
- Never guess a line number. Locate what you need in `$TXT`:

  ```bash
  grep -nE '^ ?Rule [0-9]+\.[0-9]+ '   "$TXT"   # the 53 rule statements
  grep -nE '^ ?Section [0-9]+ '        "$TXT"   # section boundaries
  grep -nE '^Word +Approved meaning/'  "$TXT"   # the dictionary, one header per page
  ```

- Read the explanatory text of a rule only when its one-line statement does not settle the question.
- For any word the dictionary flags, read its entry to get the approved alternative:

  ```bash
  grep -nE '^locate \(v\)' "$TXT"
  ```

  Take the entry inside the dictionary body, the one that carries the STE EXAMPLE columns.
  An entry in the front matter only reports what changed in this issue.

## Step 1 — Prose

Set the paths:

```bash
INPUT="$ARGUMENTS"
TXT=~/repositorios/wiki/raw/ASD-STE100_ISSUE9.txt
```

- A `.txt` input is its own prose. Set `PROSE="$INPUT"` and go to Step 2.
- A `.md` input gets a stripped prose file `<base>.txt` beside it, holding only the prose.

  If `<base>.txt` exists and is not older than the input, ask before overwriting it.
  If it is older, or missing, write it.

  Strip the frontmatter, fenced code, tables, URLs and markup. Keep every other line.
  Emit one output line per input line, so a finding can always cite the input's line number:

  ```bash
  awk '
    NR==1 && /^---[[:space:]]*$/ { infm=1; print ""; next }
    infm==1 { if (/^---[[:space:]]*$/) infm=2; print ""; next }
    /^`{3}/ { infence=!infence; print ""; next }
    infence { print ""; next }
    /^\|/   { print ""; next }
    {
      line=$0
      sub(/^>[[:space:]]?/, "", line)
      gsub(/\[([^]]*)\]\([^)]*\)/, "\\1", line)
      gsub(/https?:\/\/[^ )]*/, "", line)
      gsub(/[`*_#]/, "", line)
      gsub(/[[:space:]]+/, " ")
      print line
    }
  ' "$INPUT" > "$PROSE"
  ```

- Work from `$PROSE` for the rest of the run. Report line numbers against `$INPUT`.

## Step 2 — Mechanical pass

Run these over the whole file before reading a single sentence. They are exact.
Use `/tmp` for the intermediates and clean them up when you are done.

### 2.1 Vocabulary

Build the approved list once (855 entries, Issue 9):

```bash
grep -oE "\b[A-Z][A-Z0-9'/-]*( [A-Z0-9'/-]+)* \((art|n|v|adj|adv|prep|pron|conj|interj|det|mod|phr|aux|num)\)" "$TXT" \
  | sed 's/^ *//' | sort -u > /tmp/ste-approved.txt
```

Then find the words of `$PROSE` that are not approved, with a count and a first line:

```bash
python3 - "$PROSE" /tmp/ste-approved.txt <<'PY'
import re, sys
from collections import Counter

prose, approved = sys.argv[1], sys.argv[2]
approved = [l.strip() for l in open(approved) if l.strip()]
single = {a.split(' (')[0].lower() for a in approved if ' ' not in a.split(' (')[0]}
phrase = sorted((a.split(' (')[0].lower() for a in approved if ' ' in a.split(' (')[0]), key=len, reverse=True)
AUX = {'is', 'are', 'was', 'were', 'am', 'be', 'been', 'being', 'do', 'does', 'did', 'has', 'have', 'had'}

def stems(word):
    out = {word}
    for suffix in ('ing', 'ed', 'es', 's'):
        if word.endswith(suffix) and len(word) - len(suffix) >= 3:
            base = word[:-len(suffix)]
            out |= {base, base + 'e'}
            if len(base) > 2 and base[-1] == base[-2]:
                out |= {base[:-1], base[:-1] + 'e'}
    return out

words, aux, first = Counter(), Counter(), {}
for number, line in enumerate(open(prose).read().lower().split('\n'), 1):
    for approved_phrase in phrase:
        line = re.sub(r'\b' + re.escape(approved_phrase) + r'\b', ' ', line)
    for word in re.findall(r"[a-z]+(?:'[a-z]+)?", line):
        if word in AUX:
            aux[word] += 1
            continue
        words[word] += 1
        first.setdefault(word, number)

rows = [(c, w, first[w]) for w, c in words.items() if not stems(w) & single]
for count, word, number in sorted(rows, reverse=True):
    print(f"{count}\t{word}\tL{number}")
print('--- auxiliaries: check under rules 3.2, 3.4, 3.6 ---')
for word, count in aux.most_common():
    print(f"{count}\t{word}")
PY
```

Each candidate is a question, not a finding. Before reporting it, look it up in the dictionary
and decide whether it is a technical noun (Step 4) or an unapproved word (rule 1.6).

### 2.2 Verb constructions

```bash
grep -nE '\b(am|is|are|was|were|be|been|being) +[a-z]+ing\b' "$PROSE"   # rules 3.2, 3.4
grep -nE '\b(has|have|had) +[a-z]+(ed|en)\b'          "$PROSE"          # rule 3.2
grep -nE '\b(am|is|are|was|were|be|been|being) +[a-z]+(ed|en)\b' "$PROSE"  # rule 3.6
```

The passive voice is a finding only in procedural text. In descriptive text rule 3.6 allows it
when the agent is unknown or unimportant.

### 2.3 Word count per line

A line that is one sentence is the normal case. Count as rule 8.5, 8.6 and 8.7 require:
parentheses as one word, each number as one word, a hyphenated word as one word.

```bash
awk '{
  line=$0
  gsub(/\([^)]*\)/, " ", line)
  gsub(/[0-9]+(\.[0-9]+)*/, " ", line)
  n=split(line, w, /[^[:alnum:]-]+/); c=0
  for (i=1; i<=n; i++) if (w[i] != "") c++
  if (c > 20) printf "L%-5d %2d words%s\n", NR, c, ($0 ~ /:[[:space:]]*$/ ? "  [rule 8.4]" : "")
}' "$PROSE"
```

Over 20 words is a violation in procedural text (rule 5.1). Over 25 is a violation in descriptive
text (rule 6.3). Rerun with `c > 25` to get the descriptive list.

### 2.4 Punctuation and contractions

```bash
grep -nE "\b[A-Za-z]+'(s|t|re|ve|ll|d|m)\b" "$PROSE"   # rule 4.2
grep -n ';' "$PROSE"                                    # rule 8.1
```

The semicolon is the one punctuation mark the standard bans. Everything else is allowed by 8.1.

### 2.5 Paragraphs

Count the sentences in each block of non-empty lines. More than six is a violation of rule 6.6.

## Step 3 — Judgment pass

Work through `$INPUT` heading by heading, never loading the whole document at once.
Read the section of `$TXT` that governs what you are reading.

- Classify each part as procedural, descriptive or safety instruction.
  State the classification and the line ranges in the report. The user may correct it.
- Sections 1 to 4 and 9 always apply. Section 5 applies to procedural text, 6 to descriptive
  text, 7 to safety instructions.
- Skip what the mechanical pass already caught. Do not report the same line twice.
- Do not report a finding you cannot cite a rule for. If no rule covers it, leave it out.
- Do not report a violation of a rule whose one-line statement you have not read in `$TXT`.

These need judgment, not counting: 1.3 approved meaning, 1.9 and 1.11 technical nouns,
1.14 American spelling, 2.1 and 2.2 multi-word nouns, 3.5 and 3.7 verb form and function,
4.1 and 4.4 sentence clarity and connecting words, 4.5 articles, 5.2 to 5.5 one instruction
per sentence, imperative form, condition first, notes, 6.1 graded disclosure, 6.2 key words,
6.4 and 6.5 paragraphs, 7.1 to 7.3 safety instructions, 8.2 to 8.5, 9.1, 9.3, 9.4.

## Step 4 — Technical nouns

- A word that is not in the dictionary is not a violation when it is a technical noun or a
  technical verb of the subject field (rules 1.6 and 1.12). Judge this from the document's own
  subject matter, not from the word alone.
- A word that is a regional word, slang or jargon is a violation even as a technical noun
  (rule 1.10).
- The same item must keep the same name throughout (rules 1.9 and 1.11).
- List every technical noun you accepted in the report, with its first line. The reader confirms
  your judgement from that list, and rule 1.11 is checked against it.

## Step 5 — Report

Write the report to `<input without extension>.review.md`, beside the input.

- In English.
- A checklist, not a table. Group the findings by tier.
- Every finding carries: line number, the sentence quoted verbatim, the rule ID, what the rule
  requires, and a suggested rewrite.
- Never change the input. Never commit anything.

```markdown
# STE review — <INPUT>

- **Verdict:** NON-COMPLIANT
- **Standard:** ASD-STE100 Simplified Technical English, Issue 9 (2025-01-15)
- **Text types:** descriptive (L1–L9), procedural (L10–L14)
- **Findings:** 2 errors, 3 warnings, 1 suggestion
- **Technical nouns accepted:** panel, widget, pump, fastener, torx screw

## ❌ Errors

- [ ] **L13 · Rule 5.3** — "The cover is removed."
  Rule 5.3 requires instructions in the imperative (command) form.
  **Suggested:** Remove the cover.

## ⚠️ Warnings

- [ ] **L8 · Rule 3.6** — "The panel was removed by the technician in order to give access to the pump which was located underneath it."
  Rule 3.6 requires the active voice in procedural text; this sentence is passive and has two instructions.
  **Suggested:** The technician removes the panel to give access to the pump.

## 💡 Suggestions

- [ ] **L6 · Rule 9.1** — "Removing the panel"
  Rule 9.1 asks for a different sentence construction instead of a word-for-word repeat of the title.
  **Suggested:** Remove the panel.

## Technical nouns

- `panel` — L6, L13, L14. Not in the dictionary; a technical noun of the subject field (rule 1.6).
- `torx screw` — L26. Not in the dictionary; a technical noun (rule 1.6).
```

### Tiers

- **Error.** The text misleads, endangers, or breaks a hard limit: an approved word used with a
  wrong meaning (1.3), a verb form or complex construction the standard does not allow (3.1, 3.2,
  3.4), a safety instruction without its signal, command or explanation (7.1 to 7.3), a sentence
  over the limit (5.1, 6.3), two names for the same item (1.11).
- **Warning.** A real deviation that does not change the meaning: passive voice in procedural
  text (3.6), a missing article or demonstrative (4.5), a phrasal verb (9.3), a contraction
  (4.2), a semicolon (8.1), more than six sentences in a paragraph (6.6).
- **Suggestion.** Style and consistency: connecting words (4.4), key words (6.2), graded
  disclosure (6.1), consistent style (9.4), word-for-word repetition (9.1).

### Verdict

- `NON-COMPLIANT` when there is at least one error.
- `REVIEW` when there are warnings and no errors.
- `COMPLIANT` when there are no findings.

A document with no findings still gets a report file, with the verdict and empty sections.

## Report in the conversation

Print one paragraph: the verdict, the counts by tier, the text types found, and the path of the
report file. Do not paste the findings into the conversation.

## Never

- Never modify, reformat or "fix" the input document.
- Never write a corrected copy of the document.
- Never run `git add`, `git commit` or `git push`.
- Never report a finding without a rule ID taken from `$TXT`.
- Never check against a standard read from memory.
- Never invent an approved word that the dictionary does not list.
