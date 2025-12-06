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
      neovim
      protoc-gen-connect-go
      protoc-gen-go
      graphviz
      vhs

      # Languages
      ## Golang
      go
      golangci-lint
      gopls
      goreleaser
      gotools
      cobra-cli
      delve
      wails

      ## Python
      python3
      pyright
      python312Packages.pip
      mypy
      ruff
      poetry
      black
      uv
      virtualenv
      pyenv

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
      jdk
      lua
      lua-language-server
      luarocks
      nodejs_22
      nil
      notedown-language-server
      nixpkgs-fmt
      terraform-ls
      clang-tools
      elixir
    ];
  };
}
