---
description: Merge the session worktree into the default branch, push, and remove the worktree.
---

# Close a Session Worktree

Close one session per run. The session is the worktree you are in; the merge runs in the main
checkout because the default branch is checked out there. Never rebase, squash, amend,
force-push, delete a remote branch, stage, or commit session changes.

## Gate

- The current directory must be a linked worktree under `$HOME/worktrees/<repository>/<slug>`,
  listed by `git worktree list --porcelain`. The main checkout is the first entry; its basename
  is the repository. Otherwise report and stop.
- `git status --porcelain` must print nothing here; ignored symlinks do not count. Otherwise
  report and stop.
- HEAD must be `worktree/<slug>`; a detached HEAD stops.
- The main checkout must exist, be on the default branch, and be clean. Resolve the default
  branch as in `/worktree-open`; otherwise report and stop.

## Sync

Fetch in the main checkout; report and stop on failure. If `origin/<default>` is ahead of the
local default branch, merge it with `--ff-only`; if the two have diverged, report and stop
before touching the session branch.

## Contained

If `git -C <main> merge-base --is-ancestor worktree/<slug> <default>` succeeds, the session has
nothing to merge: a previous run already merged it, or it made no commits. Report `already
merged` when a merge commit in the default branch has the branch tip as its second parent, and
`empty session` otherwise; never create an empty merge commit. Skip to Push.

## Merge

Precondition: the branch has commits that the default branch lacks. Run
`git -C <main> merge --no-ff worktree/<slug>`. If the merge conflicts, run `git merge --abort`
there, report the conflicting paths, and stop; nothing is pushed or removed.

## Push

Precondition: the local default branch is ahead of `origin/<default>`. Push the default branch.
If the push fails, report that the merge is local and unpushed, keep the worktree and the
branch, and stop; rerunning close retries the push and finishes.

## Remove

Call `session_move` to the main checkout before deleting anything, so the session's directory
survives. Then, with the worktree registered and the branch contained in the default branch,
run `git worktree remove <target>`, `git branch -d worktree/<slug>`, and `git worktree prune`.
Delete the repository's directory under `$HOME/worktrees` only when it is empty. Removing a
worktree discards its symlinks, never their targets.

## Report

Name the merge commit, the push, the removed directory, the deleted branch, and the symlinks
discarded rather than deleted with their targets. State that the session is in the main
checkout on the default branch and that nothing was staged or amended. A rerun after a failed
push finishes that push and the removal; from the main checkout, report that no session
worktree is current and stop.
