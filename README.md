
# os

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

#open new terminal

nix --version
nix-shell -p nix-info --run "nix-info -m"
```

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix run nix-darwin -- switch --flake .
nix-shell '<home-manager>' -A install
```

```sh
# may have to nix-shell -p git
./switch <machine>
```


https://github.com/dustinlyons/nixos-config