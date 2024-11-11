#! /bin/sh

eval "$(ssh-agent -s)" > /dev/null

alias wt='source worktree' # source it so it can change the current shell
alias wts='source wt switch'
