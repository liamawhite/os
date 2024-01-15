# os

## macOS

### Bootstrapping

Install dependencies

```sh
xcode-select --install
softwareupdate --install-rosetta
```

Install nix from Determinate Systems

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

First-time installations require you to move the current /etc/nix/nix.conf out of the way.

```sh
[ -f /etc/nix/nix.conf ] && sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
```

Configure your system!

```sh
nix --extra-experimental-features 'nix-command flakes' run .#build-switch
```

Generate ssh key for github and add it.

```sh
nix run .#create-keys
gh auth login
```
### Additional Steps

Its probably possible to automate these steps but I've not had time to research how.

- Remove mission control control arrow bindings. Settings -> Keyboard -> shortcuts -> Mission Control -> All ^<direction> shortcuts. 


### Updating

Once bootstrapped, you can drop the `--extra-experimental-features 'nix-command flakes'`

```sh
nix run .#build-switch
```




https://github.com/dustinlyons/nixos-config#installing

https://search.nixos.org/packages

https://daiderd.com/nix-darwin/manual/index.html
https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236


```sh
/run/current-system/sw/bin/brew list
```

# TODO
- raycast setup

# Manual Setups
- stats
