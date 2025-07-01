#! /bin/bash

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export HISTIGNORE="pwd:ls:cd"    # Remove history data we don't want to see
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

# Add our os specific bins to the path
if [[ "$PATH" != *"$HOME/bin-os"* ]]; then
    export PATH="$PATH:$HOME/bin-os"
fi

# Add our shared bins to the path
if [[ "$PATH" != *"$HOME/bin:"* ]]; then
    export PATH="$PATH:$HOME/bin"
fi
