{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      (pkgs.neovim.override {
        configure = {
          # nix sets VIMINIT to a generated init that skips ~/.config/nvim/init.lua; this re-connects it
          customRC = "luafile $HOME/.config/nvim/init.lua";
          packages.plugins = {
            start = (with pkgs.vimPlugins; [
              auto-save-nvim
              catppuccin-nvim
              nvim-ufo
              promise-async
              neogit
              gitsigns-nvim
              diffview-nvim
              neodev-nvim
              lazydev-nvim
              nvim-lspconfig
              copilot-vim
              cmp-nvim-lsp
              cmp-path
              nvim-cmp
              trouble-nvim
              lspsaga-nvim
              inc-rename-nvim
              render-markdown-nvim
              image-nvim
              diagram-nvim
              plenary-nvim
              none-ls-nvim
              telescope-nvim
              telescope-fzf-native-nvim
              telescope-ui-select-nvim
              comment-nvim
              neo-tree-nvim
              nvim-web-devicons
              nui-nvim
              lualine-nvim
              noice-nvim
              nvim-notify
              which-key-nvim
            ]) ++ (with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
              bash c cpp go gomod html javascript json lua
              markdown markdown_inline python regex rust tsx
              typescript vim yaml terraform
            ]);
          };
        };
      })
      aspell
      aspellDicts.en
      cmake
      coreutils
      buf
      libtool
      gnumake
      autoconf
      automake
      protoc-gen-connect-go
      protoc-gen-go
      graphviz
      mermaid-cli # mmdc, used by diagram.nvim to render mermaid blocks
      vhs

      # Languages
      ## Golang
      go
      golangci-lint
      gopls
      goreleaser
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
      typescript-language-server
      vscode-langservers-extracted # markdown html css json eslin (not all are used)
      bun
      pnpm
      yarn-berry
      yaml-language-server

      ## Misc
      marksman
      bash-language-server
      dotnet-sdk_10
      jdk
      lua
      lua-language-server
      luarocks
      nodejs_22
      nixd
      nixpkgs-fmt
      dart-sass
      terraform-ls
      clang-tools
      beamPackages.elixir
    ];
  };
}
