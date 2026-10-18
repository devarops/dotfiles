---
description: Project orientation — what this is, current state, next steps
---

### Pre-flight

- Run `git log --max-count 8 --format= --name-only`.
- Every one of `AGENTS.md` and `TODO.md` that exists at the project root must appear in
  that output.
- If one does not, name it, ask the user to run `/end` in the previous session, and stop.
  Do not summarize.

Read every `./*.md` file at the project root, including any that are not standard.

Read the last eight commits with their full messages and diffs:

```bash
git log --patch --max-count 8
```

Read the uncommitted changes, if any:

```bash
git status --porcelain
git diff HEAD
```

The commit messages carry the session's context and reasoning. Read them in full, not just
the subject line.

Explain four things, as four short labelled parts:

- **What this project is:** the problem it solves and who it is for.
- **Current state:** where development stands.
- **Recent changes:** what the last eight commits changed, and why.
- **Next steps:** the work still open.

Keep the whole summary to approximately 200 words.
