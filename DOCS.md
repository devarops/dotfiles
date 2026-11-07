# Public Interface

The public interface is the install and update entrypoint plus the command surface the installation exposes: the shell functions and the OpenCode commands. Aliases and configuration files are implementation and are not listed here.

## Lifecycle

### make install
Install or update the tracked configuration in `$HOME`.
Parameters: none.
Returns: exit status.
Notes: run from the repository root.

## Shell functions

### devserver
Connect to the development server.
Parameters: none.
Errors: returns 1 when the shell is inside tmux.

### open <directory>
Open or create a tmux session for a repository.
Parameters: directory name.
Notes: expects `~/repositorios/<directory>`.

### close <directory>
Sync and close the tmux session for a repository.
Parameters: directory name.
Errors: returns 1 when git pull or push fails, or when the repository has uncommitted changes.

### fw
Open or create the free-writing tmux session.
Parameters: none.

## OpenCode commands

These commands take no formal arguments unless listed. They read the session context and ask when a reference is missing.

## Paper phases

### /paper-phase-1-outline
Choose a story, then build OUTLINE.md chapter by chapter.
Parameters: $1 raw text.

### /paper-phase-2-section
Set paragraph boundaries from the outline and comment each paragraph.
Parameters: $1 draft; $2 OUTLINE.md.

### /paper-phase-3-paragraph
Check paragraph structure against Schimel's chapter 11 and keep each comment's point current.
Parameters: $1 draft.

### /paper-phase-4-sentence
Edit sentences and flow against Schimel's chapters 12 and 13, applying deterministic changes and annotating the rest.
Parameters: $1 manuscript file.

### /paper-phase-5-word
Tighten its words against Schimel's chapters 14, 15, and 16, applying deterministic changes and annotating the rest.
Parameters: $1 manuscript file.

### /paper-phase-6-manuscript
Close the manuscript against Schimel's chapter 17, applying deterministic changes and annotating the rest.
Parameters: $1 manuscript directory.

## Docs phases

### /docs-phase-2-section
Assemble slots into paragraphs, set boundaries, and comment each paragraph.
Parameters: $1 raw text; $2 outline.

### /docs-phase-3-paragraph
Check paragraph order against ASD-STE100 and keep each comment's point current.
Parameters: $1 raw text.

### /docs-phase-5-word
Tighten its words against ASD-STE100, applying deterministic edits and recording the rest as annotations.
Parameters: $1 manual.

## Blog

### /blog-phase-5-word
Tighten its verbs and word choice against Williams and Strunk, applying deterministic edits and recording the rest.
Parameters: $1 blog post.

## ATDD

### /atdd-acceptance
Evaluate the acceptance spec, report the first failing criterion, and activate one skipped criterion.
Parameters: none.

### /atdd-red
Write the acceptance test for the first failing criterion whose test is missing.
Parameters: none.

## TDD and AFK

### /afk-fail
Re-validate the uncommitted failing unit test and commit it.
Parameters: none.

### /afk-green
Produce the smallest possible production code to make the current failing test pass.
Parameters: none.

### /afk-red
Write and validate the next failing unit test; leave it uncommitted for afk-fail.
Parameters: none.

### /afk-refactor
Apply small, safe refactorings.
Parameters: none.

### /afk-score
Evaluate the codebase for code smells and assign scores based on adherence to best practices.
Parameters: none.

### /tdd-green
Produce the smallest possible production code required to make the current failing test pass.
Parameters: none.

### /tdd-red
Identify the next smallest failing test that incrementally advances the system toward the failing acceptance criterion.
Parameters: none.

### /tdd-refactor
Guide the user in applying small, safe refactorings.
Parameters: none.

### /fail
Run the test suite during the Red TDD phase, verify one and only one test fails for the right reason, and commit if so.
Parameters: none.

## Reference

### /reference-classify
Assign one category to each bibliography reference by what it contributes and how the project and the set use it, one record at a time.
Parameters: $ARGUMENTS bibliography.

### /reference-extract
Extract screening fields and fill NA fields from each reference's own source, except category.
Parameters: $ARGUMENTS bibliography.

### /reference-normalize
Normalize bibliography structure, sort entries and fields, and ensure mandatory fields are present with {NA} placeholders.
Parameters: $ARGUMENTS bibliography.

## Task

### /task-add
Add a two-line item to the session open list.
Parameters: none.

### /task-focus
Mark one open item as the current focus.
Parameters: none.

### /task-list
Show the session open items with numbers, focus, and Tests.
Parameters: none.

### /task-move
Move one open item into the best-fitting TODO.md section.
Parameters: none.

### /task-purge
Remove open items whose Test passes, asking about the ones it cannot evaluate.
Parameters: none.

### /task-remove
Remove one open item immediately and report it.
Parameters: none.

## Sync

### /sync-agents
Bring AGENTS.md in line with the session and the repository.
Parameters: none.

### /sync-changelog
Record committed public-interface changes in CHANGELOG.md.
Parameters: none.

### /sync-docs
Bring DOCS.md in line with the public interface.
Parameters: none.

### /sync-readme
Bring README.md in line with the project for non-technical readers.
Parameters: none.

### /sync-todo
Update TODO.md and close the session open list.
Parameters: none.

## Worktree

### /worktree-open
Create a per-session worktree, share ignored assets, and move the session into it.
Parameters: $ARGUMENTS slug.

### /worktree-close
Merge the session worktree into the default branch, push, and remove the worktree.
Parameters: none.

## Wiki

### /wiki-add
Ingest a source or idea into the LLM Wiki via structured interview and write to bundle/tmp.md
Parameters: $1 optional source or idea.

### /wiki-file
Rename bundle/tmp.md to the correct OKF filename based on parent selection, update log.md, and commit
Parameters: none.

## Session and utility

### /ask-me
Interview the user briefly until the idea is clear.
Parameters: none.

### /commit-message
Generate a commit message from the staged diff and this session.
Parameters: none.

### /end
Close the session by syncing the documentation and verifying it.
Parameters: none.

### /fix-citation
Rank the bibliography references that can fix one citation, reading each candidate in full and quoting evidence.
Parameters: citation from the context.

### /grill-me
Interview the user exhaustively until every decision is settled.
Parameters: none.

### /iterate-quickfix-list
Walk a list one item at a time.
Parameters: $1 optional file.

### /notify-team
Draft a Spanish Slack notice of a completed change and send it after approval.
Parameters: none.

### /pr-review
Interactive PR review that walks git diff changes, classifies findings, and posts a structured review.
Parameters: $1 pull request.

### /release-version
Prepare and publish a semantic-version release.
Parameters: $1 target version.

### /stand-by
Reflect the user's thinking back for verification, then stand by without acting.
Parameters: none.

### /start
Project orientation — what this is, current state, next steps.
Parameters: none.

### /test-data-mutation
Mutate a CSV fixture in a given data directory and verify validation (e.g., frictionless) catches it.
Parameters: $1 data directory.

### /tidy-command
Tidy the command by repairing defects, generalizing over-specific rules, and staying under 1000 words.
Parameters: $1 command name.

### /write-r-script
Generate beginner-friendly, linear R scripts with strict naming conventions, modular file-based I/O, and Spanish commentary.
Parameters: target script from the context.
