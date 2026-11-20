---
description: Stop speaking replies for the rest of this session.
---

# Turn Off Voice Mode

Voice mode is off for this session, from this message onward. Stop ending replies with a
spoken summary until a later message turns it back on. The written reply is unchanged.

## State

The toggle is the conversation: if no earlier message turned voice mode on, or a later message
already turned it off, report `already off` and change nothing.

## Keep

Do not delete any note in `/tmp/opencode`. `/voice-replay` still plays the most recent one after
this message.

## Confirm

Answer in text only, with no audio, and state that voice mode is off and that `/voice-replay`
still works.

## Idempotency

A second request to turn it off reports `already off` and changes nothing. Turning it back on
reverses it.
