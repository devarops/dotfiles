---
description: Generate a commit message from the staged diff and this session.
---

## Task

1. Run `git diff --cached --quiet`. If it exits zero, there are no staged changes: inform the user and stop.
2. Run `git diff --cached` and read the staged changes. Ignore unstaged and untracked changes.
3. Run `git log --patch --max-count 8` on the current branch and read the full messages and patches. If fewer than eight commits exist, read all of them.
4. Read the team prose guide at https://islas.dev/guia_de_estilo/prosa before writing. Apply its principles to English prose.
5. Build the private editorial brief described below. Do not show it.
6. Write the commit message from the brief.
7. Validate and revise the message against the checklist below.
8. Present only the message and wait. Do not commit before approval. If the user edits it or asks for changes, apply them. After approval, commit the staged changes with the approved text. Do not stage, unstage, amend, or push.

## Private editorial brief

Build a private brief in English, in the team voice. Include only the sections that carry material. Keep it concise; the hard word limits apply only to the final body.

- Objective: what we were trying to accomplish.
- Requirements: constraints, preferences, requirements, and scope boundaries that shaped the staged diff.
- Decisions: what we chose and why, including what we rejected.
- Work State: Completed, Active, and Blocked, but only where the state explains the staged diff. Never list status bookkeeping.
- Next Move: follow-ups created by this diff, only with concrete evidence. Omit speculation.
- Important Context: facts a future reader cannot recover from the code or the staged diff.
- Recent Arc: tell the last eight commits as a short story using ABDCE: Action, Background, Development, Climax, Ending. The ending is where the work stands now. Use the commit messages and patches to see the direction, but strip implementation detail. See Schimel's Science Writing as Storytelling at ~/repositorios/wiki/raw/schimel2012writing.txt.
- Excluded: list the session material you deliberately left out, so it cannot leak into the message. In particular, note pre-existing issues and unrelated follow-ups that do not explain the diff.

Filter every item before drafting:

- Causal test: keep it only if it explains why the staged diff exists, what the diff changes, what we rejected, or what must happen next because of this diff. Exclude pre-existing issues and unrelated session work that do not explain the diff.
- Novelty test: compare it semantically with the last eight commit subjects and bodies. Keep it only if it adds information the reader would not already have. A more specific detail that changes what the reader learns is new; a paraphrase is not. If this commit reverses or updates an earlier decision, state the replacement and why, not the old decision in full.
- If the last eight commits do not connect to the staged diff, use them only for deduplication and omit any positioning sentence. Do not invent a connection.

If no material survives, present the subject alone.

## Message

### Subject

Start with a gitmoji followed by an imperative verb.
Do not use Conventional Commits prefixes.
Keep the first line under 72 characters.
Leave the second line blank.
The subject may repeat an earlier subject when it accurately summarizes the staged diff; only the body is deduplicated.

### Body

Write plain prose in normal paragraphs, separated by blank lines. No labels, no Markdown, no backticks, no single or double quotes.
Write in English and follow the team prose guide.
The body, excluding the subject line, is at most 400 words. Each body sentence is at most 25 words.
Use active voice. Make the team the actor for human decisions and actions: "we decided," "we rejected," "we changed." Never write I, the user, the author, the assistant, or the agent. Never mention an AI assistant or agent; all responsibility and attribution belong to the team.
Files, commands, tools, checks, and other non-AI things may be grammatical subjects when they are the natural subject.
Do not restate the subject line. Do not restate what the staged diff makes obvious. Do not repeat a fact already stated earlier in the message. Each fact appears once.
Use at most one positioning sentence from the Recent Arc. Include it only when it tells the reader something new about how this commit advances or redirects the arc and helps place the change. Otherwise omit it.
Keep only the signal. Less is better than more.

## Before presenting

Check and revise the message:

1. Every body sentence passes the causal test and the novelty test.
2. No body sentence repeats a prior subject or body, or an earlier sentence in this message.
3. The subject is a gitmoji plus an imperative verb, under 72 characters, with a blank second line and no Conventional Commits prefix.
4. The body is plain text, with no labels, Markdown, backticks, or quotes.
5. Each body sentence is at most 25 words; the body is at most 400 words.
6. Human actions use "we"; the message never uses I, the user, the author, the assistant, or the agent.
7. No AI assistant or agent is an actor, subject, or reference; files, commands, tools, and other non-AI things may be subjects.
8. At most one positioning sentence appears, and only if it is new and causally related.
9. The body does not restate the subject or what the diff makes obvious.
10. The message follows the team prose guide.

Present only the message. Wait for approval, edits, or a requested change. After approval, commit the staged changes with the approved message.
