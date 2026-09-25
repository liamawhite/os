{ user, root, pkgs, secretsFiles ? [], ... }:

{
  home-manager.users.${user} = { config, lib, ... }:
    let
      xdg_home = config.home.homeDirectory;
      xdg_configHome = "${xdg_home}/.config";
      zsh-autosuggestions = pkgs.callPackage ./zsh-autosuggestions.nix { };

      # Symlinks to a place in this repo so we can edit them without rebuilding the system
      useLocal = rel: config.lib.file.mkOutOfStoreSymlink "${root}/modules/dotfiles/${rel}";

      # Parse a secrets file with KEY=VALUE pairs into an attribute set
      parseSecretsFile = file:
        let
          content = builtins.readFile file;
          lines = lib.splitString "\n" content;
          nonEmptyLines = builtins.filter (line: line != "" && !(lib.hasPrefix "#" line)) lines;
          parseLine = line:
            let
              parts = lib.splitString "=" line;
              key = builtins.head parts;
              value = lib.concatStringsSep "=" (builtins.tail parts);
            in
            { name = key; value = value; };
        in
        builtins.listToAttrs (map parseLine nonEmptyLines);

      # Merge secrets from all files
      allSecrets = lib.foldl' (acc: file: acc // (parseSecretsFile file)) {} secretsFiles;

      # Generate .env content from secrets attribute set
      secretsContent = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "${name}=\"${value}\"") allSecrets
      );
    in
    {
      # Preserve files created by Herdr onboarding before Home Manager checks
      # for collisions. Only these two files move; runtime state stays in place.
      home.activation.backupHerdrFiles = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
        for file in ${lib.escapeShellArg "${xdg_configHome}/herdr/config.toml"} ${lib.escapeShellArg "${xdg_home}/.claude/hooks/herdr-agent-state.sh"}; do
          if [ -f "$file" ] && [ ! -L "$file" ]; then
            run ${pkgs.coreutils}/bin/mv --backup=numbered "$file" "$file.before-herdr"
          fi
        done
      '';

      home.file = {
        "${xdg_configHome}/starship.toml".source = useLocal "starship.toml";
        "${xdg_configHome}/wezterm".source = useLocal "wezterm";
        "${xdg_configHome}/nvim".source = useLocal "nvim";
        "${xdg_configHome}/ghostty".source = useLocal "ghostty";
        "${xdg_configHome}/tmux".source = useLocal "tmux";
        "${xdg_configHome}/herdr/config.toml".source = useLocal "herdr/config.toml";
        "${xdg_home}/.tmux/plugins/resurrect".source = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect";
        "${xdg_home}/.tmux/plugins/continuum".source = "${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum";
        "${xdg_home}/.zshrc".source = useLocal "zshrc";
        "${xdg_home}/.zsh".source = useLocal "zsh";
        "${xdg_home}/bin".source = useLocal "bin";
        "${xdg_home}/.claude/settings.json".source = useLocal "claude/settings.json";
        "${xdg_home}/.claude/hooks/herdr-agent-state.sh".source = useLocal "claude/hooks/herdr-agent-state.sh";
        "${xdg_home}/workspaces".source = useLocal "workspaces";
        "${xdg_home}/.workstreams".source = useLocal "workstreams";
"${xdg_home}/.ssh" = { source = ./ssh; recursive = true; };
        "${xdg_home}/.zshplugins/zsh-autosuggestions.zsh" = { source = "${zsh-autosuggestions}/zsh/zsh-autosuggestions.zsh"; };

        # msf-cli configuration
        "${xdg_home}/.msf-cli/config.yaml".source = useLocal "msf-cli/config.yaml";

        # Secrets .env file (always created, even if empty)
        "${xdg_home}/.env".text = secretsContent;
      };
    };
}
