---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git push:*), Bash(git log:*)
argument-hint: [message]
description: Stage all changes, commit with message, and push to remote
---

## Task

Create a git commit and push changes to the remote repository.

If the user provided a commit message in $ARGUMENTS, use that exact message.
If no message was provided, analyze the changes and create an appropriate commit message.

Steps:
1. Run `git status` to see current changes
2. Run `git diff --cached --stat` and `git diff --stat` to understand changes
3. Stage all relevant changes with `git add`
4. Create a commit with the message (IMPORTANT: Do NOT include any Claude Code attribution or co-authoring)
5. Push to remote with `git push`

The commit message should be concise and descriptive, focusing on what changed and why.
