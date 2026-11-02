# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- `open` starts the session with the development container (`dev-run`).

## [0.1.0] - 2026-11-01

### Added

- `make install` installs or updates the tracked configuration in `$HOME`.
- `devserver` connects to the development server.
- `open <directory>` opens or creates a tmux session for a repository.
- `close <directory>` syncs and closes the tmux session for a repository.
- `fw` opens or creates the free-writing tmux session.
- Paper-phase OpenCode commands: `paper-phase-1-outline`, `paper-phase-2-section`, `paper-phase-3-paragraph`, `paper-phase-4-sentence`, `paper-phase-5-word`, and `paper-phase-6-manuscript`.
- Docs-phase OpenCode commands: `docs-phase-2-section`, `docs-phase-3-paragraph`, and `docs-phase-5-word`.
- Blog OpenCode command: `blog-phase-5-word`.
- TDD and AFK OpenCode commands: `afk-acceptance`, `afk-green`, `afk-red`, `afk-refactor`, `afk-score`, `tdd-green`, `tdd-red`, `tdd-refactor`, and `fail`.
- Reference OpenCode commands: `reference-classify`, `reference-extract`, and `reference-normalize`.
- Task OpenCode commands: `task-add`, `task-focus`, `task-list`, `task-move`, `task-purge`, and `task-remove`.
- Sync OpenCode commands: `sync-agents`, `sync-changelog`, `sync-docs`, `sync-readme`, and `sync-todo`.
- Worktree OpenCode commands: `worktree-open` and `worktree-close`.
- Wiki OpenCode commands: `wiki-add` and `wiki-file`.
- Session and utility OpenCode commands: `ask-me`, `commit-message`, `end`, `fix-citation`, `grill-me`, `iterate-quickfix-list`, `notify-team`, `pr-review`, `release-version`, `stand-by`, `start`, `test-data-mutation`, `tidy-command`, and `write-r-script`.

[Unreleased]: https://github.com/devarops/dotfiles/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/devarops/dotfiles/releases/tag/v0.1.0
