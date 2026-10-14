---
description: Generate a commit message that carries the session's signal, from git status --verbose.
---

## Task

1. Run `git status --verbose` to identify changes in the staging area.
1. If there are no staged changes, inform the user and stop.
1. Ignore unstaged changes and describe only the staged changes.
1. Read the last eight commits with `git log --patch --max-count 8` to learn the project's commit style and the direction of the recent work.
1. Write one commit message from this session: what was decided, what a future reader must know, and what comes next.
1. Present the message and wait for the user to approve it, edit it, or ask for a change. Do not commit before approval.
1. After approval, commit the staged changes with the approved message.

## Body

Give a group to each of the following that carries signal, and omit any group that does not:

1. The decision: what was chosen and why, including what was rejected.
2. The context: facts a future reader cannot recover from the code or the diff.
3. The next step: the follow-up this change creates. Include it only when there is concrete
   evidence of the intended next step; in doubt, omit it.

Write free prose, one sentence per line, and separate the groups with a blank line. Add no
labels and no Markdown. Each group is one to four sentences, each of at most
25 words.

Keep only the signal. Less is better than more: a small change earns a small body. Prefer
intent and motivation over implementation detail, and do not restate what the diff makes
obvious.

## Format

- Start with a gitmoji followed by an imperative verb.
- Do not use the Conventional Commits prefixes (feat:, fix:, refactor:, and so on).
- Keep the first line under 72 characters.
- Leave the second line blank.
- Then write the body, using the groups above.
- Plain text only: no backticks, no single quotes, no double quotes.
- Write clear, professional English with correct grammar and spelling.
