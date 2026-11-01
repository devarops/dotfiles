# Dotfiles

Configuration for a Linux development machine. Every tracked path installs into
`$HOME`, so the repository root is the home directory: `.bash_aliases` becomes
`~/.bash_aliases`. A root file change affects the home directory, not just the repository.

## Deployment

Installed as a bare Git repository whose work-tree is `$HOME`; `make install` runs the clone,
the forced checkout, and the untracked-file setting. The `gdot` alias wraps the same pair;
no build step.

## Layout

- **Shell**: `.bash_aliases` (aliases; sources `.bash_functions` and `~/.vault/.secrets`),
  `.bash_functions` (`devserver`, `open`, `close`, `fw`).
- **Terminal**: `.tmux.conf`; `.config/ghostty/config.ghostty` (font, theme, window
  options; Ghostty reads it at launch).
- **Editor**: `.config/nvim/` (Lua). `omegadeck.lua` is a separate profile referenced by
  `.journalotrc`.
- **OpenCode**: `.config/opencode/` — `agent/`, `commands/`, `opencode.json`,
  `prose-options.md`, `documentation-contract.md`, and a global `AGENTS.md` for the wiki
  bundle and prose rules; OpenCode loads both.
- **Other**: `.gitconfig` (default branch `develop`, editor `nvim`, global ignore),
  `.config/git/ignore` (`.OPEN.md`, Python and R artifacts), `.ssh/config`, `.lintr` (R,
  100-character lines), `.journalotrc`.

## Conventions

- **Commits**: a gitmoji followed by an imperative English summary under 72 characters,
  a blank second line, then a short body explaining why.
- **Verification**: no test suite, CI, or build. Read the affected file; `bash -n`
  checks shell syntax. Ghostty validates with `ghostty +validate-config --config-file=<path>`
  and lists themes with `ghostty +list-themes`.
- **Secrets**: `~/.vault/.secrets` is sourced by the shell and is not in this repository.
  Never commit secrets, tokens, or private keys.
- **Release**: `DOCS.md`, `CHANGELOG.md`, and version tags exist; `/release-version` follows
  its release gates.

## Public interface

The public interface is the install and update entrypoint plus the command surface the installation exposes: the shell functions and the OpenCode commands.
Configuration files, aliases, and internal helpers are implementation, not part of the public interface.

## Version 1.0.0 release conditions

- The install and update entrypoint is idempotent: rerunning it on an installed machine changes nothing or updates safely.
- The installation is non-destructive: it backs up or refuses to overwrite existing files.

## OpenCode commands

`.config/opencode/commands/` holds prompt templates, one command per file, each with a
`description` in YAML frontmatter.

- Command names are verb-first, except sets, which share one prefix; `pr-review` avoids the
  built-in `/review`. Read a hyphenated name as an imperative: `commit-message` is `commit a
  message`. A `name:` field repeats the filename, so rename both.
- Keep each command under 1,000 words.
- `/release-version` commits the release changes the user has staged, after the user
  confirms the commit message. It never stages or unstages, amends, or pushes a branch;
  it pushes the release tag and syncs tags.
- **External-reader commands** modify prose for readers outside the team; they guard against
  dispossession. **Internal-reader commands** modify team-internal prose and may use more help.
  `paper-*` commands except the outline phase, and `blog-*` commands, are always external-reader;
  the outline phase has no reader mode and does not read `prose-options.md`.
  `docs-*` and `iterate-quickfix-list` determine the reader from the artifact.
  External-reader commands read and follow
  `~/.config/opencode/prose-options.md`, which carries the reader modes, direction step,
  safe and finished alternatives, and authorship guard. Following it includes
  reading `~/repositorios/wiki/bundle/4a.md` and its `4a.*.md` children before interviewing
  about wording.
- For judgment calls in paper editing commands, follow Schimel's principles and ideas
  first (`~/repositorios/wiki/raw/schimel2012writing.txt`).
- Phase commands confirm each step against their declared inputs: write the step's changes,
  report, and wait for the user to commit when an input changed; if no input changed, continue.
  Phase 1 checks `OUTLINE.md` instead, because that is the file it writes.
- The paper-phase family has five scales and one closing pass in one section order. Phase 1
  is the only Selection command and the only command without a reader mode; phases 2–6 are
  external-reader. Each phase owns its scale: the outline owns the story and `OUTLINE.md`, the
  section owns paragraph boundaries, the paragraph owns internal structure, the sentence owns
  the sentence, the word owns the word, and the manuscript owns the whole manuscript. The
  manuscript phase crosses scales by design and never selects the story. An outline item is
  never a paragraph definition.
- In a paper draft, `<!-- ... -->` are structural comments (item label and point),
  `[[ ... ]]` are gaps resolved later by iterate-quickfix-list, and `XXX` are user-only
  placeholders. The outline phase writes none; the sentence, word, and manuscript phases ignore
  the comments and leave them in place even when stale, with headings as their only fences. The
  manuscript phase never writes `XXX`. The user commits between steps; no phase command stages
  or commits.
- The external-reader rule does not bind `wiki-add`; it synthesises the concept body, which
  the user confirms.
- `/start` refuses unless every existing root `AGENTS.md` and `TODO.md` appears in the last
  eight commits, and reads uncommitted changes as input. Use `git log --max-count 8` with no
  pathspec, which filters before the limit. The detector is deliberately narrow: it catches a
  missing `/end`, not one overtaken by later work.
- `task-*` tracks `.OPEN.md`: flat `- [ ]` or `- [*]` items with a six-space `Test:` line.
  `/start` accepts only an absent or zero-byte file; `sync-todo` purges and deletes it.
- `sync-*` brings the five documentation files in line with the repository;
  `documentation-contract.md` holds their shared rules. `/end` runs them in order before
  verifying.
- `/tidy-command` takes one command name, requires a clean tree, and edits only that command.
  It records an overlap boundary in `AGENTS.md` and leaves work for another command as a
  `TODO.md` task or a report.
- Field ownership in the `reference-*` family: `reference-normalize` owns structure, ordering,
  and field presence; `reference-extract` owns the thirteen screening fields and placeholders
  in every other field except `category`; `reference-classify` owns `category`. The commands do
  not name one another.

### Idempotency and convergence

A command is idempotent and convergent. Every durable action names the precondition that
makes a second run on the same work a no-op; after the action it is false. A reversed action
leaves no durable effect; a command with no durable action passes. When the work is already
done, the command reports it and stops without writing.
