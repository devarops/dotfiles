---
name: review-pr
description: Interactive PR review that walks through git diff changes, classifies findings, and submits a structured GitHub review. Use when a pull request needs review.
---

# Skill: review-pr

## Workflow

### 1. Ask for the PR number

Ask the user for the pull request number. Only accept a numeric value.

### 2. Fetch the PR branch

```bash
gh pr view <NUMBER> --json headRefName,baseRefName -q '.headRefName'
```

Store the branch name and base branch. If base branch is not `develop`, note it for later use.

### 3. Get the diff

```bash
git fetch origin develop
gh pr checkout <NUMBER>
git diff origin/develop..HEAD
git diff origin/develop..HEAD --name-only
```

Store the list of changed files and the full diff. If `develop` does not exist, ask the user which base branch to use.

### 4. Fetch reference documents

Fetch **both** of these URLs:

- `https://islas.dev/guia_de_estilo/comentarios_en_revisiones` — to get the PR Checklist and understand how to write review comments.
- `https://islas.dev/guia_de_estilo/STYLEGUIDE` — to use as a second checklist for naming, style, and code conventions.

If the repository has a file named `analyses.json` at its root, also read `class-3.md` and use its task list as an additional reference during review.

### 5. Create the review file

Create the directory and file: `.review/PR_<NUMBER>.md`

Initialize it with this structure (checklists, not tables):

```markdown
# Review of PR #<NUMBER>

## 👍 Hecho

Positive observations / good things first.

## 🩹 Fix aplicado

Checklist of changes that were fixed directly.

- [x] <file>: <description of what was fixed>

## ❓ Pregunta / Curiosidad

Checklist of questions for the author.

- [ ] <file>: <question>

## 💡 Sugerencia opcional

Checklist of optional suggestions.

- [ ] <file>: <suggestion>

## ⚠️ Cambio requerido

Checklist of required changes.

- [ ] <file>: <required change>

---
```

### 6. Iterate through each changed file

For each file in the diff:

1. Read the current file content.
2. Show the diff hunk for that file.
3. Identify opportunities for improvement by comparing against:
   - The PR Checklist items.
   - The STYLEGUIDE conventions.
4. **Present only one opportunity at a time**.
5. For each opportunity, offer these **five options**:

   | Option | Meaning | When to use |
   |--------|---------|-------------|
   | **Curious honest question** | Ask "why?" without assuming intent. | When you don't understand the reasoning. |
   | **Fix and explain** | Apply the change directly, commit, and push. | Typos, factual errors, formatting — low pedagogical value, just fix. |
   | **Optional suggestion** | A subjective improvement, not required. | Personal preference, nice-to-haves. |
   | **Required change** | A functionally incorrect or policy-violating issue. | Contradicts team style guide, is functionally wrong, or breaks standards. |
   | **Ignore** | Skip this opportunity entirely. | Not relevant or not worth addressing. |

6. After the user chooses:
   - If **Fix and explain**: edit the file in-place (do not commit yet). Add a checklist entry under 🔧 Fix aplicado. Multiple fixes in the same file accumulate.
   - If **Curious honest question**: add a checklist entry under ❓ Pregunta / Curiosidad.
   - If **Optional suggestion**: add a checklist entry under 💡 Sugerencia opcional.
   - If **Required change**: add a checklist entry under ⚠️ Cambio requerido.
   - If **Ignore**: do nothing, move on.

7. **After finishing all opportunities for the current file**: if there are accumulated "fix and explain" changes, commit and push them as a **single commit per file**:
   ```bash
   git add <FILE>
   git commit -m "🩹 Fix <filename>: <summary of all fixes>"
   git push
   ```
   Example: `🩹 Fix CITATION.cff: correct version from 5.0.1 to 1.0.1 and fix typo`

### 8. After all files are processed

Show the user `.review/PR_<NUMBER>.md` and ask for **approval**.

### 9. If approved, submit the review

```bash
gh pr review <NUMBER> --request-changes --body-file .review/PR_<NUMBER>.md
```

## Important notes

- Always start the review file with positive observations (👍 Hecho) before listing issues.
- Be kind and respectful. Follow the review writing guidelines from: https://islas.dev/guia_de_estilo/comentarios_en_revisiones
- Use "nosotros" and interrogative form when asking questions.
- If a question can be answered by exploring the codebase, explore instead of asking.
- One commit per file for fixes.
