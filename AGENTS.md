# Dotfiles

Configuration for a Linux development machine. Every tracked path installs into
`$HOME`, so the repository root is the home directory: `.bash_aliases` becomes
`~/.bash_aliases`, `.config/opencode/commands/` becomes `~/.config/opencode/commands/`.
Adding or renaming a file at the root therefore changes the home directory, not just
the repository.

## Deployment

Installed as a bare Git repository whose work-tree is `$HOME` — see `README.md` and
the `install` target in `Makefile`:

```bash
git clone --bare . "$HOME/dotfiles.git"
git --git-dir="$HOME/dotfiles.git" --work-tree="$HOME" checkout --force
```

The `gdot` alias wraps the same `--git-dir`/`--work-tree` pair. There is no build
step; files take effect when they are checked out.

## Layout

- **Shell**: `.bash_aliases` (aliases; sources `.bash_functions` and `~/.vault/.secrets`),
  `.bash_functions` (`devserver`, `open`, `close`, `fw`).
- **Terminal**: `.tmux.conf`.
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
  affected file; for shell code, `bash -n` catches syntax errors.
- **Secrets**: `~/.vault/.secrets` is sourced by the shell and is not in this repository.
  Never commit secrets, tokens, or private keys.
- **Release**: there is no `DOCS.md`, no `CHANGELOG.md`, and no version tag, so `/end` skips
  its interface steps and `/release-version` stops at its gate.

## OpenCode commands

`.config/opencode/commands/` holds prompt templates, one command per file, each with a
`description` in YAML frontmatter.

- Command names are verb-first, except when the command belongs to a set; every command
  in a set shares the set's common prefix. A built-in command name is also an exception;
  `pr-review` avoids the built-in `/review`. Read a hyphenated name as an imperative
  phrase: `commit-message` is `commit a message`, so it is verb-first.
- Keep each command under 2,000 words.
- If a command crosses 2,000 words, trim it to under 1,000.
- `/release-version` commits the release changes the user has staged, after the user
  approves the commit message. It never stages or unstages, amends, or pushes a branch;
  it pushes the release tag and syncs tags.
- **External-reader commands** modify prose for readers outside the team; they guard against
  dispossession. **Internal-reader commands** modify team-internal prose and may use more help.
  `paper-*` and `blog-*` are always external-reader. `docs-*` and `quickfix-list` determine the
  reader from the artifact. External-reader commands read and follow
  `~/.config/opencode/prose-options.md`, which carries the authorship rule, direction step,
  safe alternatives, finished alternatives, and authorship guard. Following it includes
  reading `~/repositorios/wiki/bundle/4a.md` and its `4a.*.md` children before interviewing
  about wording.
- For judgment calls in paper editing commands, follow Schimel's principles and ideas
  first (`~/repositorios/wiki/raw/schimel2012writing.txt`).
- The paper-phase family has four scales: phase 0 owns the story and its frame, section roles,
  and the ordered outline items in `OUTLINE.md`; phase 1 owns paragraph boundaries, each
  paragraph's point and structure, and sentence placement; phase 2 the sentence; phase 3 the
  word. Keep each phase inside its scale. An outline item is a label, a job, a question, and
  a local arc role, never a paragraph definition.
- In a paper draft, `<!-- ... -->` are structural comments (phase 1 writes one comment per
  paragraph: item label, point, and structure), `[[ ... ]]` are gaps or directions resolved
  later by quickfix-list, and `XXX` are author-only placeholders. Phase 0 writes none; phases
  2 and 3 leave all three untouched. Phase 1 does not commit; the author commits between
  runs, since phase 1 requires a clean tree.
- The external-reader rule does not bind `wiki-add`; it synthesises the concept body, which
  the author approves.
- `/start` refuses unless every existing root `AGENTS.md` and `TODO.md` appears in the last
  eight commits, and reads uncommitted changes as input. Use `git log --max-count 8` with no
  pathspec, which filters before the limit.
- The `/start` pre-flight catches a missing `/end`, not one overtaken by later work; the
  narrow detector is deliberate.
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
