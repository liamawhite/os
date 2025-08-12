{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      aspell
      aspellDicts.en
      cmake
      coreutils
      buf
      libtool
      gnumake
      autoconf
      automake
      emacs
      neovim
      protoc-gen-connect-go
      protoc-gen-go
      vscode
      graphviz

      # Languages
      ## Golang
      go
      golangci-lint
      gopls
      goreleaser
      gotools
      delve
      cobra-cli

      ## Python
      python3
      pyright
      python312Packages.pip
      mypy
      ruff
      poetry
      black
      uv

      ## Rust
      rustc
      cargo
      rustfmt
      rust-analyzer

      ## JS/TS
      tailwindcss-language-server
      tailwindcss_4
      nodePackages.typescript-language-server
      vscode-langservers-extracted # markdown html css json eslin (not all are used)
      bun
      pnpm
      yarn-berry
      yaml-language-server

      ## Misc
      nodePackages.bash-language-server
      dotnet-sdk
      jdk23 # latest LTS
      lua
      lua-language-server
      luarocks
      nodejs_20 # latest LTS
      nil
      nixpkgs-fmt
      terraform-ls
      clang-tools
      elixir
    ];
  };
}
