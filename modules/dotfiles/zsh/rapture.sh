#! /bin/sh

# Fuzzy rapture has to be an alias otherwise it doesn't work
alias rap='rapture assume $(rapture role ls | cut -f 2 -d " " | fzf)'
eval "$( command rapture shell-init )"


