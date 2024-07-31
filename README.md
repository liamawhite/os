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

Clone this repo

```sh
mkdir ~/.ssh
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
git clone https://github.com/liamawhite/os.git
```

Configure your system!

```sh
nix --extra-experimental-features 'nix-command flakes' run .#build-switch
```

### Additional Steps

Its probably possible to automate these steps but I've not had time to research how.

- Remove mission control control arrow bindings. Settings -> Keyboard -> shortcuts -> Mission Control -> All ^<direction> shortcuts. 

## Setup syncthing...

### Updating

Once bootstrapped, you can just use `./switch`

```sh
switch
```

https://github.com/dustinlyons/nixos-config#installing