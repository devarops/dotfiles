# Troubleshooting — tmux clipboard

## Problem

A TUI application (e.g. `ncdu`, `nvim`, `ranger`, `lf`, `fzf`) can copy
text to the system clipboard when run directly in the terminal, but the
same copy operation silently fails when the application is running inside
a tmux pane.

## Root cause

Many TUI applications write to the clipboard using the **OSC 52** terminal
escape sequence.

When no terminal multiplexer is involved, OSC 52 flows straight from the
application to the terminal emulator (ptyxis, gnome-terminal, kitty,
alacritty, …). The terminal emulator is responsible for receiving it and
updating the system clipboard.

Tmux intercepts all OSC 52 sequences by default: it stores the content in
its own internal buffer but **does not forward** the sequence to the
parent terminal. The system clipboard is never updated. From the user's
perspective, the copy appeared to succeed inside the TUI but nothing can
be pasted.

## Solution

### Step 1 — Enable OSC 52 passthrough in tmux

```tmux
set -g set-clipboard on
```

What this does:

| Value        | Behaviour in tmux ≥ 3.2                                    |
|--------------|------------------------------------------------------------|
| `off`        | Ignore OSC 52 entirely.                                    |
| `external`   | Accept OSC 52 data into tmux's buffer. Do **not** forward. |
| `on`         | Accept OSC 52 **and** forward the sequence to the terminal.|

**`on`** is what you need. The terminal emulator then receives the
sequence and writes to the system clipboard.

### Step 2 — Use the correct clipboard tool for your display server

When you *manually* yank text in tmux copy mode (or paste into it),
the commands `wl-copy`/`wl-paste` (Wayland) or `xclip`/`xsel` (X11)
must match your session type.

Check with:

```bash
echo "$XDG_SESSION_TYPE"
```

- **Wayland** → `wl-copy` / `wl-paste`
- **X11**     → `xclip -sel clip -i` / `xclip -sel clip -o`

#### Binding examples that auto-detect (Wayland-first, fallback to X11)

**Yank (copy selection → system clipboard):**
```tmux
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel \
  "wl-copy 2>/dev/null || xclip -sel clip -i"
```

**Paste (system clipboard → tmux pane):**
```tmux
bind C-v run "tmux set-buffer \"$(wl-paste 2>/dev/null || xclip -sel clip -o 2>/dev/null)\"; tmux paste-buffer"
```

## Apply the changes

```bash
tmux source-file ~/.tmux.conf
```

No need to restart tmux. If you prefer a clean slate:

```bash
tmux kill-server
tmux
```

## Verify it works

1. Open a TUI inside tmux and use its copy command.
2. Outside tmux, paste with `Ctrl+v` (or middle-click).

If the clipboard is still empty, your terminal emulator may not support
OSC 52. In that case, fall back to a binding that runs `wl-copy` or
`xclip` directly (Step 2 above) whenever you need system-clipboard access.

## Files referenced

- `~/.tmux.conf` — tmux configuration
- `TROUBLESHOOTING.md` — this file
