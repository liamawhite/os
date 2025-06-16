# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Commands

### Building and Switching Configuration
- `switch` - Apply configuration changes (detects hostname automatically)
- `nix run .#macbookpro-docusign-2025-switch` - Apply configuration for MacBook Pro
- `nix run .#macstudio-personal-2023-switch` - Apply configuration for Mac Studio
- `nix build .#darwinConfigurations.macbookpro-docusign-2025.system` - Build MacBook Pro config
- `nix build .#darwinConfigurations.macstudio-personal-2023.system` - Build Mac Studio config

### Development
- `nix flake update` - Update flake inputs
- `nixpkgs-fmt .` - Format Nix files
- `nix flake check` - Validate flake configuration

## Architecture

This is a personal macOS system configuration using Nix Flakes, nix-darwin, and Home Manager.

### Key Structure
- **flake.nix**: Main flake definition with inputs and multiple host configurations
- **hosts/darwin/**: Host-specific configurations
  - **shared.nix**: Common darwin configuration shared across hosts
  - **macbookpro-docusign-2025/**: MacBook Pro specific config (nixbld ID: 30000)
  - **macstudio-personal-2023/**: Mac Studio specific config (nixbld ID: 30001)
- **modules/darwin/**: macOS-specific configurations (homebrew, packages, system settings)
- **modules/shared/**: Cross-platform configurations (programs, packages, dotfiles)
- **apps/**: Build scripts for different architectures and hosts
- **overlays/**: Package overlays (currently just licenser)

### Configuration Flow
1. **flake.nix** defines multiple system configurations in `darwinConfigurations`
2. Each host configuration imports **hosts/darwin/shared.nix** for common settings
3. Host-specific files override shared settings (nixbld IDs, hostnames, etc.)
4. **modules/darwin/default.nix** configures macOS-specific settings and Home Manager
5. **modules/shared/default.nix** provides nixpkgs configuration

### Package Management
- **Nix packages**: Defined in `modules/shared/packages/all.nix` and `modules/darwin/packages.nix`
- **Homebrew**: Managed via `modules/darwin/homebrew.nix` for macOS-specific apps and tools that don't work well with Nix
- **Custom packages**: Local derivations in `modules/shared/packages/` for tools not in nixpkgs

### Dotfiles Management
- Dotfiles are managed through Home Manager in `modules/darwin/files/`
- Configuration files are organized by application (nvim, wezterm, zsh, etc.)
- The system uses a hardcoded user "liam" and email "liamawhite@gmail.com"

### Key Features
- Automatic garbage collection (weekly)
- Syncthing integration for configuration sync
- Complete development environment with language servers for Go, Python, Rust, JS/TS
- Window management via AeroSpace
- Terminal setup with Ghostty/WezTerm, Neovim, and Zsh