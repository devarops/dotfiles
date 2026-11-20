---
description: Speak a summary at the end of every reply for the rest of this session.
---

# Turn On Voice Mode

Voice mode is on for this session, from this message onward. End every reply with a spoken
summary until a later message turns it off. The written reply is unchanged; the audio is added
to it.

## State

The toggle is the conversation and nothing else: no file records it. If an earlier message
already turned voice mode on and no later message turned it off, report `already on` and
change nothing. A new session starts with voice mode off.

## Summary

Read `~/.config/opencode/character.md` and write the summary as the character it describes. If
the file cannot be read, report that and continue in your own voice.

Write in the language of the reply, with no lists, no file paths, and no commands read aloud.
Say what was done and what the user needs next. It summarises the reply; it never reads it back.

## Speak

The audio plays wherever the tool call is issued. Issue it after the last sentence and write
nothing after it; any text that follows will appear after the note.

1. Set the output path. The name carries the session and the time.
   `out=/tmp/opencode/voice-$OPENCODE_SESSION_ID-$(date +%Y%m%d-%H%M%S).wav`
2. Synthesise from standard input so quotes survive, without playing yet.
   `say -o "$out" <<'TXT'`, then the text, then `TXT`.
3. Play `pw-play "$out"`.

The script pads the start and normalises the level; the command does neither.

If `OPENCODE_SESSION_ID` is unset, or synthesis fails, report it and still answer in text. A
failed note never hides the answer.

## Report

State once that voice mode is on and that the user can replay the most recent note with
`/voice-replay`.

## Idempotency

A second request to turn voice mode on finds it already on, reports that, and writes no audio.
Turning voice mode off reverses it.
