{ root, config, pkgs, ... }:

let
  xdg_home = config.home.homeDirectory;
  # xdg_configHome = "${xdg_home}/.config";
  # xdg_dataHome   = "${xdg_home}/.local/share";
  # xdg_stateHome  = "${xdg_home}/.local/state";
  shared = import ../../shared/files/default.nix { inherit config pkgs root; };

  # Symlinks to a place in this repo so we can edit them without rebuilding the system
  useLocal = rel: config.lib.file.mkOutOfStoreSymlink "${root}/modules/darwin/files/${rel}";
in
shared //
{
  "${xdg_home}/bin-os".source = useLocal "bin";
  "${xdg_home}/.aerospace.toml".source = useLocal "aerospace.toml";
}
