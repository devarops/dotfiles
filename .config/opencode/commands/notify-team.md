---
description: Draft a Spanish Slack notice of a completed change and send it after approval.
---

# Notify the Team

Send one Slack notification per run, and only after the user approves its text.

## Gate

- `SLACK_WEBHOOK_URL` must be set and start with `https://hooks.slack.com/services/`. Otherwise report which condition failed and stop. Never print the URL.
- Read <https://islas.dev/guia_de_estilo/prosa> in full before writing; if the page cannot be read, report and stop.
- If the established facts do not say who made the change, assume Evaristo made it.

## Draft

Write the message in Spanish, and keep file names, commands, URLs, and technical terms in English.
Use one to four sentences, and give each sentence at most 25 words.
Write in the third person and name the person who made the change (Evaristo); never write I, the user, the author, the assistant, or the agent.
A first draft may spend one sentence on what changed, one on how, and one on why; that shape is a suggestion, not a rule.
State each fact once, and claim nothing the facts do not support.

## Approve

Present the message and the word count of each sentence.
Wait. Apply edits and present the message again.
Send only the text the user approves in its presented form.

## Send

Post the approved text as JSON:

```bash
curl -sS -X POST -H 'Content-type: application/json' --data @- -w '\nHTTP %{http_code}\n' "$SLACK_WEBHOOK_URL"
```

Read the payload from a heredoc so quotes in the text survive.
Send the approved text once, and send nothing else.
A webhook cannot edit or delete a message, so the send cannot be undone.

## Report

Report the response body and the HTTP status. A body other than `ok`, or a status other than 200, ends the run without a retry.
State that the message is live, that it cannot be edited or deleted, and that nothing was staged or committed.

## Idempotency and convergence

The only durable action is the send. Its precondition is the user's approval of the exact text presented; the run reports and stops after the send, so a second run must draft again and win fresh approval.
A run that stops at the gate, or a draft the user declines, sends nothing and leaves no durable effect.
