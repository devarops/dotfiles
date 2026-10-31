# Dotfiles

Configuration for a Linux development machine. Every tracked path installs into
`$HOME`, so the repository root is the home directory: `.bash_aliases` becomes
`~/.bash_aliases`. Adding or renaming a root file changes the home directory, not just
the repository.

## Deployment

Installed as a bare Git repository whose work-tree is `$HOME`; the `install` target in
`Makefile` runs the clone, the forced checkout, and the untracked-file setting.

The `gdot` alias wraps the same `--git-dir`/`--work-tree` pair. There is no build
step; files take effect when they are checked out.

## Layout

- **Shell**: `.bash_aliases` (aliases; sources `.bash_functions` and `~/.vault/.secrets`),
  `.bash_functions` (`devserver`, `open`, `close`, `fw`).
- **Terminal**: `.tmux.conf`; `.config/ghostty/config.ghostty` (font, theme, window
  options; Ghostty reads it at launch).
- **Editor**: `.config/nvim/` (Lua). `omegadeck.lua` is a separate profile referenced by
  `.journalotrc`.
- **OpenCode**: `.config/opencode/` — `agent/`, `commands/`, `opencode.json`,
  `prose-options.md`, and the global `AGENTS.md`, a separate short file that only points to
  the wiki bundle and `prose-options.md`; the root `AGENTS.md` is this repository's guide.
  OpenCode loads both.
- **Other**: `.gitconfig` (default branch `develop`, editor `nvim`), `.ssh/config`,
  `.lintr` (R, 100-character lines), `.journalotrc`.

## Conventions

- **Commits**: a gitmoji followed by an imperative English summary under 72 characters,
  a blank second line, then a short body explaining why.
- **Verification**: there is no test suite, CI, or build. Check a change by reading the
  affected file; for shell code, `bash -n` catches syntax errors. Ghostty validates another
  copy with `ghostty +validate-config --config-file=<path>`, and lists theme names with
  `ghostty +list-themes`.
- **Secrets**: `~/.vault/.secrets` is sourced by the shell and is not in this repository.
  Never commit secrets, tokens, or private keys.
- **Release**: there is no `DOCS.md`, no `CHANGELOG.md`, and no version tag, so `/end` skips
  its interface steps and `/release-version` stops at its gate.

## OpenCode commands

`.config/opencode/commands/` holds prompt templates, one command per file, each with a
`description` in YAML frontmatter.

- Command names are verb-first, except when the command belongs to a set, which shares one
  prefix; `pr-review` also avoids the built-in `/review`. Read a hyphenated name as an
  imperative: `commit-message` is `commit a message`. A `name:` field, when present,
  repeats the filename, so rename both.
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
- The paper-phase family has five scales and one closing pass, and all six share one section
  order. Phase 1 is the only Selection command and the only
  command without a reader mode; phases 2–6 are external-reader. The outline phase owns the
  story and its frame, section roles, and the ordered outline items in `OUTLINE.md`; the
  section phase owns paragraph boundaries and the initial per-paragraph comments; the
  paragraph phase owns internal structure, sentence order within a paragraph, and point
  updates; the sentence phase owns the sentence; the word phase owns the word; the manuscript
  phase owns the whole manuscript and the issues that span scales. Keep each phase inside its
  scale, except the manuscript phase, which crosses scales by design: it applies deterministic
  fixes everywhere and annotates the rest, auditing delivery and never selecting the story.
  An outline item is never a paragraph definition.
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
- `/tidy-command` takes one command name, requires a clean tree, and edits only that command.
  It records an overlap boundary in `AGENTS.md` and leaves work for another command as a
  `TODO.md` task or a report.
- Field ownership in the `reference-*` family: `reference-normalize` owns structure, ordering,
  and field presence; `reference-extract` owns the thirteen screening fields and placeholders
  in every other field except `category`; `reference-classify` owns `category`. The commands do
  not name one another.

### Idempotency and convergence

A command is idempotent and convergent. Every durable action — a write, append, create,
delete, rename, commit, tag, push, or remote sync whose effect survives the run — names the
precondition, a state of a file, the tree, the index, a tag, or the remote, that makes a
second run on the same unit of work a no-op; after the action that precondition is false. An
action the command reverses leaves no durable effect, and a command with no durable action
passes. When the work is already done, the command reports it and stops without writing.
