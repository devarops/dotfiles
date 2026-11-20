---
description: Play the most recent spoken note of this session.
---

# Replay the Last Voice Note

Play the newest note for this session and do nothing else. Do not synthesise, do not
summarise, and do not change whether voice mode is on.

## Find

Notes are `/tmp/opencode/voice-$OPENCODE_SESSION_ID-<date>-<time>.wav`. Pick the newest by
modification time:

`ls -t /tmp/opencode/voice-$OPENCODE_SESSION_ID-*.wav | head -1`

If `OPENCODE_SESSION_ID` is unset, or nothing matches, report `nothing to replay yet` and stop.

## Play

Run `pw-play` on that file and report its name. If the player exits non-zero, report that and
stop.

## Idempotency

No durable effect: it plays a file and writes nothing. A second run plays the same note again.
