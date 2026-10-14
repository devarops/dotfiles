---
name: pr-review
description: Interactive PR review that walks git diff changes, classifies findings, and posts a structured review
---

You are performing a PR review. The branch under review is provided as `$1`.

## Workflow

### 1. Prepare the repository

Confirm both prerequisites; if either fails, stop and ask the user to fix it.

- `.review/` is ignored: `git check-ignore .review/`. If it exits non-zero, ask the user to add `.review/` to `.gitignore`.
- The working tree is clean: `git status --porcelain`. If it returns anything, ask the user to commit or stash.

### 2. Fetch and choose the branch

```bash
git fetch --prune origin
```

If `$1` is set, verify it exists on `origin` and use it. Otherwise list the `origin` branches except `develop` and `origin/HEAD` and ask the user which branch is under review.

```bash
git switch <BRANCH>
```

### 3. Get the diff

```bash
git diff origin/develop...HEAD
git diff origin/develop...HEAD --name-only
```

The base branch is `develop`; if `origin/develop` is missing, ask the user which base to use. The three-dot range is deliberate: it starts at the merge base, so the diff shows only what the branch changed however far `develop` has moved ahead.

### 4. Read the guides and choose the checklist

Fetch `https://islas.dev/guia_de_estilo/` and read every page it links to.

Review every file against `STYLEGUIDE` and one checklist from `review_checklists` (Class 1 or Class 3, chosen below). Apply any other guide page where relevant: levels and layers, comment writing, prose.

#### Choose the repository class

Guess from the remote and the repository contents:

- GitHub remote without `analyses.json` at the root: Class 1.
- Bitbucket remote with `analyses.json` at the root: Class 3.
- Otherwise: no guess.

Confirm the guess, or ask the user to choose Class 1 or Class 3 if there is none. Use the matching checklist for the rest of the review.

### 5. Create or update the review file

The file is `.review/<BRANCH>.md`, with each `/` in the branch name replaced by `-`. Create the directory if needed.

Each invocation is one round. If the file does not exist, this is Round 1 and you write the title and context line. If it exists, find the highest `## Round N` and append round N+1 at the end. If it has no `## Round N` heading, treat the contents as Round 1 (add the heading above them, leaving the date blank if unknown) and append Round 2; ask only if they cannot be read as the five sections. Never overwrite or delete an earlier round.

Reconstruct the tracked set: every unchecked item (`- [ ]`) in the most recent block. These are what you re-verify in step 6.

Blocks run oldest first, so the newest — the one posted in step 8 — is last. Use this structure:

```markdown
# Review of <BRANCH>

Base: <BASE> · Class <N> (<host>) · Checklist: review_checklists

## Round N — <YYYY-MM-DD>

### 👍 Done
### ❓ Question / Curiosity
### ⚠️ Required change
### 💡 Optional suggestion
### 🩹 Fix applied
```

Sections are checklists, not tables: good findings first, then questions for the author, required changes, optional suggestions, and changes fixed directly. Items read `- [ ] <file>: <text>`, checked `- [x]` once resolved; write `(none)` when a section is empty. From Round 2, move resolved items to 👍 Done (`- [x] <file>: addressed from Round 1 — <what changed>`), close moot ones with a note, and re-list still-open items tagged `(carried from Round 1)`.

### 6. Iterate through each changed file

For each file in the diff:

On round 2 and later, first re-verify the tracked set from step 5 against the current code: move resolved items to 👍 Done, close moot ones with a note, and re-list the rest tagged `(carried from Round N)`. Carried items are never offered the five options again; ask the user for a status only when the code cannot settle it, such as a ❓ answered in the pull request thread.

1. Read the current file content and show its diff hunk.
2. Identify good findings (anything praiseworthy: clear naming, a simpler design, solid tests, helpful docstrings) and opportunities, against the guides from step 4.
3. Handle good findings first, one at a time: offer **Keep / Drop / Reword** and record kept ones under 👍 Done as `- [x] <file>: <what is good>`.
4. Then handle opportunities, one at a time: wait for the answer and record it. The five options:
   - **Curious honest question** — you don't understand the reasoning: ask "why?" without assuming intent; add it under ❓ and fix nothing.
   - **Required change** — functionally wrong or against the guide: add it under ⚠️; don't fix; the author applies it.
   - **Optional suggestion** — subjective, a nice-to-have: add it under 💡; don't fix; the author decides.
   - **Fix and explain** — typo, factual error, formatting: edit in place and add it under 🩹; don't commit yet.
   - **Ignore** — skip it.

After finishing a file, if "fix and explain" changes accumulated, commit and push them as a single commit per file:

```bash
git add <FILE>
git commit -m "🩹 Fix <filename>: <summary of all fixes>"
git push
```

### 7. After all files are processed

Show the user `.review/<BRANCH>.md` and ask for approval.

### 8. Post the review

Once approved, tell the user to paste the newest `## Round N` block (the last one) into the pull request and request changes — or to approve the pull request when the round has no open items. This command posts nothing itself.

## Important notes

- Be kind and respectful; follow the comment-writing guide: https://islas.dev/guia_de_estilo/comentarios_en_revisiones
- Write requests as questions and use "we" rather than "you".
- If a question can be answered by exploring the codebase, explore instead of asking.
