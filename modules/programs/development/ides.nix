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
      hugo
      wails

      ## Python
      pyenv # use pyenv to manage all python versions
      pyright
      python312Packages.pip
      mypy
      ruff
      poetry
      black
      uv
      virtualenv

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
      dotnet-sdk_10
      jdk
      lua
      lua-language-server
      luarocks
      nodejs_22
      nil
      notedown-language-server
      nixpkgs-fmt
      dart-sass
      terraform-ls
      clang-tools
      elixir
    ];
  };
}
