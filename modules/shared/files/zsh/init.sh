#! /bin/bash

if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

# Add our bins/helpers to the path
if [[ ! "$PATH" == $HOME/bin/* ]]; then
    export PATH="$PATH:$HOME/bin"
fi

