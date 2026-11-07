# Dotfiles

Configuration for a Linux development machine. Every tracked path installs into
`$HOME`, so the repository root is the home directory: `.bash_aliases` becomes
`~/.bash_aliases`. A root file change affects the home directory, not just the repository.

## Deployment

Installed as a bare Git repository whose work-tree is `$HOME`; `make install` runs the clone,
the forced checkout, and the untracked-file setting.

## Layout

- **Shell**: `.bash_aliases` (aliases; sources `.bash_functions` and `~/.vault/.secrets`),
  `.bash_functions` (`devserver`, `open`, `close`, `fw`).
- **Terminal**: `.tmux.conf`; `.config/ghostty/config.ghostty` (font, theme, window
  options).
- **Editor**: `.config/nvim/` (Lua). `omegadeck.lua` is a separate profile referenced by
  `.journalotrc`.
- **OpenCode**: `.config/opencode/` — `commands/`, `opencode.json`, `prose-options.md`,
  `documentation-contract.md`, and a global `AGENTS.md`. `opencode.json` sets only
  `instructions`, which loads that global guide; no custom agents exist, so a session starts
  on the built-in default agent.
- **Other**: `.gitconfig` (default branch `develop`, editor `nvim`, global ignore),
  `.config/git/ignore` (`.OPEN.md`, Python and R artifacts), `.ssh/config`, `.lintr` (R),
  `.journalotrc`.

## Shell vocabulary

- **`dev-*`** uses the development image: `Dockerfile.dev`, the `develop` Compose
  profile and service, and the `:develop` tag. It builds FROM the production image
  and carries qed plus the testing and development tools. `open` starts the session
  with `dev-run`; where a repository has no `develop` service, `dev-run` fails, so add
  the dev image.
- **`prod-*`** uses the production image: `Dockerfile`, the default Compose service,
  and the `:latest` tag. It carries only runtime dependencies.
- Names are `<environment>-<action>[-no-compose][-devarops]`, always in that order.
  Plain names target the `islasgeci` service and registry; `-devarops` targets
  `evaristor` through the `devarops` service. `-no-compose` selects the direct `docker`
  path. Existing gaps in the matrix are intentional.
- Containers are `_dev` for the development image and `_prod` for the production image.
- `CI` names the continuous-integration pipeline, not an image environment; the
  `/release-version` gate keeps that meaning.
- `devserver` and `init-devserver` name the remote development machine, not the
  development image.

## Conventions

- **Commits**: a gitmoji followed by an imperative English summary under 72 characters,
  a blank second line, then a short body explaining why.
- **Verification**: no test suite, CI, or build. Read the affected file; `bash -n`
  checks shell syntax. Ghostty validates with `ghostty +validate-config --config-file=<path>`
  and lists themes with `ghostty +list-themes`.
- **Secrets**: `~/.vault/.secrets` is sourced by the shell and is not in this repository.
  Never commit secrets, tokens, or private keys.
- **Release**: `/release-version` follows its release gates.

## Public interface

The public interface is the install and update entrypoint plus the command surface the installation exposes: the shell functions and the OpenCode commands.
Configuration files, aliases, and internal helpers are implementation, not part of the public interface.

## Version 1.0.0 release conditions

- The install and update entrypoint is idempotent: rerunning it on an installed machine changes nothing or updates safely.
- The installation is non-destructive: it backs up or refuses to overwrite existing files.

## OpenCode commands

`.config/opencode/commands/` holds prompt templates, one per file, each with a
`description` in YAML frontmatter.

- Names are verb-first, except sets sharing one prefix; `pr-review` avoids the built-in
  `/review`. A `name:` field repeats the filename, so rename both. Keep each command under
  1,000 words.
- **External-reader commands** modify prose for readers outside the team; they guard against
  dispossession. **Internal-reader commands** modify team-internal prose and may use more help.
  `paper-*` except the outline phase, and `blog-*`, are always external-reader; the outline
  phase has no reader mode and does not read `prose-options.md`; `docs-*` and
  `iterate-quickfix-list` read the reader from the artifact. External-reader commands follow
  `~/.config/opencode/prose-options.md`, including `4a.md` and its children.
- For judgment calls in paper editing commands, follow Schimel's principles
  first (`~/repositorios/wiki/raw/schimel2012writing.txt`).
- The paper phases run in one section order, each owning one scale: outline the story and
  `OUTLINE.md`, section the paragraph boundaries, paragraph the internal structure, sentence
  the sentence, word the word, manuscript the whole manuscript. Phase 1 alone selects the
  story; phases 2–6 are external-reader. The manuscript crosses scales by design, and an
  outline item is never a paragraph definition.
- Phase commands write, report, and wait for the user to commit when an input changed;
  otherwise they continue.
- In a paper draft, `<!-- ... -->` are structural comments (item label and point),
  `[[ ... ]]` are gaps resolved later by iterate-quickfix-list, and `XXX` are user-only
  placeholders. The outline phase writes none; the sentence, word, and manuscript phases leave
  the comments in place even when stale, with headings as their only fences. The manuscript
  phase never writes `XXX`; no phase command stages or commits.
- The external-reader rule does not bind `wiki-add`; it synthesises the concept body for the
  user to confirm.
- `/start` refuses unless every root `AGENTS.md` and `TODO.md` appears in the last eight
  commits, and reads uncommitted changes as input. Use `git log --max-count 8` with no
  pathspec; the detector catches a missing `/end`.
- `task-*` tracks `.OPEN.md`: flat `- [ ]` or `- [*]` items with a six-space `Test:` line.
  `/start` accepts only an absent or zero-byte file; `sync-todo` purges and deletes it.
- `sync-*` brings the five documentation files in line; `documentation-contract.md` holds
  their shared rules. `/end` runs them in order.
- Field ownership in the `reference-*` family: `reference-normalize` owns structure, ordering,
  and field presence; `reference-extract` owns the thirteen screening fields and placeholders
  in every other field except `category`; `reference-classify` owns `category`. The commands do
  not name one another.
- The ATDD outer loop is `atdd-*`; `tdd-*` and `afk-*` are the interactive and
  autonomous inner loops. `atdd-acceptance` reports a failing criterion without an error,
  emits `<promise>COMPLETE</promise>` when none is skipped, and otherwise removes one `skip`
  for `atdd-red`, leaving the edit for the harness. In the autonomous Red phase, `afk-red`
  writes and validates one failing unit test and `afk-fail` re-validates and commits it.

### Idempotency and convergence

A command is idempotent and convergent: every durable action names the precondition that
makes a second run on the same work a no-op, and that precondition is false afterwards. A
reversed action leaves no durable effect; a command with no durable action passes. When the
work is done, the command reports it and stops without writing.
