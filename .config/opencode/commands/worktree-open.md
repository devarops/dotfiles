---
description: Create a per-session worktree, share ignored assets, and move the session into it.
---

# Open a Session Worktree

Open one session per run. A session is a branch and a directory under `$HOME/worktrees`; the
main checkout stays on its default branch. Never fetch, build, start Docker, stage, commit, or
push.

## Argument

The slug is `$ARGUMENTS`. If it is empty, ask `What subject is this?`, wait, and allow one
correction. Normalize the answer to lowercase, replace spaces and underscores with hyphens, and
require `^[a-z0-9][a-z0-9-]*$`; otherwise report and stop.

## Gate

- The current directory must be inside a git worktree with at least one commit. A bare
  repository, a missing HEAD, or an absent `.git` stops.
- The main checkout is the first `worktree` entry in `git worktree list --porcelain`. Its
  basename is the repository name.
- The target is `$HOME/worktrees/<repository>/<slug>`; the branch is `worktree/<slug>`.
- The base is the default branch: the local branch named by
  `git symbolic-ref --short refs/remotes/origin/HEAD` without `origin/`; otherwise `main`,
  `master`, or `develop` when one exists; otherwise the current HEAD. Report the base.
- If the target is registered in `git worktree list`, it is an existing session: verify that
  its HEAD is `worktree/<slug>`, move the session there, verify, report `already open`, and
  stop without writing. If the target exists but is not registered, or the branch exists
  without the target, report and stop.
- If the main checkout has uncommitted changes, print `git status --porcelain` there and state
  that they stay in the main checkout; proceed. Never stash them, move them, or clean them.

## Create

Precondition: the target directory and the branch are both absent. Run
`mkdir --parents "$HOME/worktrees/<repository>"`, then `git worktree add -b worktree/<slug>
<base> "$HOME/worktrees/<repository>/<slug>"` from the main checkout. Report a non-zero exit
and stop.

For each ignored entry at the top level of the main checkout (`git -C <main> status --ignored
--porcelain`, lines starting `!!`), create a symlink in the new worktree pointing at the main
checkout's absolute path. Precondition: the link is absent. Never copy, never follow a link
target, and never replace a real file or directory that is already present. Report every link
created.

## Enter

Call `session_move` with the target. Then verify `pwd`, `git rev-parse --abbrev-ref HEAD`, and a
clean `git status --porcelain` there. If any check fails, report and stop.

## Report

Name the worktree path, the branch, the base commit, every symlink, and the container name this
directory will expect: `<basename>_ci`. State that ignored state is shared with the main
checkout and that no container exists yet. If the session came from another linked worktree,
name that worktree and state that it stays open. A second run with the same slug moves the
session and changes nothing.
