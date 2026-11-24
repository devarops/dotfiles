---
description: Count ISO 5055 unit-level quality weaknesses in a commit's files.
---

This command executes in non-interactive mode as part of an automated process. Do not expect or request user input.

The caller appends a commit and a file list to this prompt. Count the weaknesses in those files at that commit.

## Task

- Read `~/.config/opencode/quality-practices.md` before counting.
- Take the commit and the files from the text appended below this prompt. The block names the commit on a `Commit:` line and lists one path per line under `Files:`. If either part is missing or unreadable, output `<error>FAIL: missing commit or file list</error>` and stop.
- Read each listed file at that commit, for example with `git show <commit>:<path>`. Do not read the working tree, other files, or `harness.log`.
- Count every weakness instance in those files and sum them, following the counting rule in the practices file. Skip a listed file that does not exist at the commit.
- Do not run tests, enter the development container, edit any file, or write any file.
- Print exactly one line, `<score>N</score>`, where `N` is the non-negative integer total. Print nothing else.
