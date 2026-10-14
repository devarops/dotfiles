---
name: pr-review
description: Interactive PR review that walks through git diff changes, classifies findings, and produces a structured review to post on the hosting platform
---

You are performing a PR review. The branch under review is provided as the first argument (`$1`).

## Workflow

### 1. Prepare the repository

Before anything else, confirm both prerequisites. If either fails, stop and ask the user to fix it before continuing.

- `.review/` is ignored: run `git check-ignore .review/`. If it exits non-zero, ask the user to add `.review/` to `.gitignore`.
- The working tree is clean: run `git status --porcelain`. If it returns anything, ask the user to commit or stash.

### 2. Fetch and choose the branch

```bash
git fetch --prune origin
```

If `$1` is set, treat it as the branch under review and verify it exists on `origin`. Otherwise, list the `origin` branches except `develop` and `origin/HEAD`, and ask the user which branch is under review.

Switch to the chosen branch:

```bash
git switch <BRANCH>
```

### 3. Get the diff

```bash
git diff origin/develop...HEAD
git diff origin/develop...HEAD --name-only
```

The base branch is `develop`. If `origin/develop` does not exist, ask the user which base branch to use and use it instead.

The three-dot range is deliberate. It compares from the merge base, so the diff shows only what the branch changed, regardless of how far `develop` has moved ahead.

### 4. Read the guides and choose the checklist

Fetch `https://islas.dev/guia_de_estilo/` and read every guide page it links to.

Always review every file against:

- `STYLEGUIDE`: the conventions for naming, style, and code.
- One checklist from `review_checklists`: the Class 1 or Class 3 list, chosen below.

Apply any other guide page where it is relevant to the file, such as the levels-and-layers architecture, the comment-writing guide, or the prose guide.

#### Choose the repository class

Guess the class from the remote and the repository contents:

- GitHub remote without `analyses.json` at the repository root: Class 1.
- Bitbucket remote with `analyses.json` at the repository root: Class 3.
- Anything else: no guess.

Confirm the guess with the user. If there is no guess, ask the user to choose Class 1 or Class 3. Use the matching checklist from `review_checklists` for the rest of the review.

### 5. Create or update the review file

The review file is `.review/<BRANCH>.md`, with each `/` in the branch name replaced by `-`.

Create the directory and the file. If it already exists, ask the user which review round this is.

Initialize it with this structure (checklists, not tables):

```markdown
# Review of <BRANCH>

## 👍 Done

Positive observations / good things first.

- [x] Completed task from a previous review round.

## ❓ Question / Curiosity

Checklist of questions for the author.

- [ ] <file>: <question>

## ⚠️ Required change

Checklist of required changes.

- [ ] <file>: <required change>

## 💡 Optional suggestion

Checklist of optional suggestions.

- [ ] <file>: <suggestion>

## 🩹 Fix applied

Checklist of changes that were fixed directly.

- [x] <file>: <description of what was fixed>

---
```

### 6. Iterate through each changed file

For each file in the diff:

1. Read the current file content.
2. Show the diff hunk for that file.
3. Identify opportunities for improvement against the guides from step 4: the `STYLEGUIDE`, the chosen checklist from `review_checklists`, and any other guide page relevant to the file.
4. **Present only one opportunity at a time**.
5. For each opportunity, offer these **five options**:

   | Option | Meaning | When to use |
   |--------|---------|-------------|
   | **Curious honest question** | Ask "why?" without assuming intent. | When you don't understand the reasoning. |
   | **Required change** | A functionally incorrect or policy-violating issue. | Contradicts the style guide, is functionally wrong, or breaks standards. |
   | **Optional suggestion** | A subjective improvement, not required. | Personal preference, nice-to-haves. |
   | **Fix and explain** | Apply the change directly, commit, and push. | Typos, factual errors, formatting — low pedagogical value, just fix. |
   | **Ignore** | Skip this opportunity entirely. | Not relevant or not worth addressing. |

7. Wait for the user's answer. After the user chooses:
   - If **Fix and explain**: edit the file in-place (do not commit yet). Add a checklist entry under 🩹 Fix applied. Multiple fixes in the same file accumulate.
   - If **Curious honest question**: add a checklist entry under ❓ Question / Curiosity. Do not fix anything — you are asking for more information, not requesting changes.
   - If **Optional suggestion**: add a checklist entry under 💡 Optional suggestion. Do not fix anything — the author decides whether to accept it.
   - If **Required change**: add a checklist entry under ⚠️ Required change. Do not fix anything — the author applies it.
   - If **Ignore**: do nothing, move on.

**After finishing all opportunities for the current file:** if there are accumulated "fix and explain" changes, commit and push them as a **single commit per file**:

```bash
git add <FILE>
git commit -m "🩹 Fix <filename>: <summary of all fixes>"
git push
```

Example: `🩹 Fix CITATION.cff: correct version from 5.0.1 to 1.0.1 and fix typo`

### 7. After all files are processed

Show the user `.review/<BRANCH>.md` and ask for **approval**.

### 8. Post the review

Once the user approves, tell them to paste the contents of `.review/<BRANCH>.md` into the pull request on the hosting platform and select request changes. This command posts nothing itself.

## Important notes

- Always start the review file with positive observations (👍 Done) before listing issues.
- Be kind and respectful. Follow the comment-writing guide: https://islas.dev/guia_de_estilo/comentarios_en_revisiones
- Write requests as questions and use "we" rather than "you".
- If a question can be answered by exploring the codebase, explore instead of asking.
- One commit per file for fixes.
