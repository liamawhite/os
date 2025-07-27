# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Commands

### Building and Switching Configuration
- `nix run .#macbookpro-docusign-2025-switch` - Apply configuration for MacBook Pro (user: liam.white)
- `nix run .#macstudio-personal-2023-switch` - Apply configuration for Mac Studio (user: liam)
- `nix build .#darwinConfigurations.macbookpro-docusign-2025.system` - Build MacBook Pro config
- `nix build .#darwinConfigurations.macstudio-personal-2023.system` - Build Mac Studio config

Note: Host-specific switch scripts are located in `apps/aarch64-darwin/` and handle the full build + switch process

### Development
- `nix flake update` - Update flake inputs
- `nixpkgs-fmt .` - Format Nix files
- `nix flake check` - Validate flake configuration

## Architecture

This is a personal macOS system configuration using Nix Flakes, nix-darwin, and Home Manager.

### Key Structure
- **flake.nix**: Main flake definition with inputs and multiple host configurations
- **hosts/darwin/**: Host-specific configurations
  - **macbookpro-docusign-2025.nix**: MacBook Pro config (user: liam.white, buildId: 350)
  - **macstudio-personal-2023.nix**: Mac Studio config (user: liam, buildId: 351)
- **modules/**: Modular configuration components
  - **darwin/**: macOS-specific settings (user, home-manager integration)
  - **programs/**: Application configurations (development tools, terminal, GUI apps)
  - **dotfiles/**: Managed dotfiles (nvim, wezterm, zsh, etc.)
- **apps/**: Build scripts for different architectures and hosts
- **overlays/**: Package overlays (currently just licenser for custom packages)

### Configuration Flow
1. **flake.nix** defines multiple system configurations in `darwinConfigurations`
2. Each host configuration directly imports necessary modules (no shared.nix)
3. Host-specific files set user, machine ID, build ID, and import required modules
4. **modules/darwin/home-manager.nix** integrates Home Manager with mac-app-util
5. **modules/nix.nix** and **modules/nixpkgs.nix** provide core Nix configuration

### Package Management
- **Nix packages**: Installed through program-specific modules in `modules/programs/`
- **Development tools**: Configured in `modules/programs/development/` (cloud tools, IDEs, agents)
- **Terminal applications**: Managed in `modules/programs/terminal/`
- **Custom packages**: Available through overlays (licenser package from personal repo)

### Dotfiles Management
- Dotfiles are managed in `modules/dotfiles/` and applied through Home Manager
- Configuration files are organized by application (nvim, wezterm, zsh, aerospace, emacs, etc.)
- The system uses different users per host and shared email "liamawhite@gmail.com"

#### Emacs Configuration Architecture
- **Modular structure**: `modules/dotfiles/emacs.d/modules/` contains feature-specific modules
- **Core module** (`modules/core/`): Essential functionality (Evil mode, UI, package management, keybindings)
- **Feature modules**: `completions/`, `themes/` - each with packages.el and main loader
- **Evil keybindings**: Space leader key with organized prefixes (fb=find buffer, ff=find file, fg=grep)
- **Modern completion**: Vertico + Consult + Embark + Marginalia + Orderless stack
- **Pinned packages**: All packages use specific commit hashes for reproducibility

### Key Features
- Automatic garbage collection (weekly)
- Complete development environment with cloud tools, IDEs, and language servers
- Window management via AeroSpace
- Terminal setup with WezTerm, Neovim, and Zsh
- AI development agents (Claude, etc.) integrated into workflow
- Minimal Emacs setup with UI cleanup and spell checking support

## Important Instructions

- NEVER run the 'switch' command or any nix rebuild commands automatically
- The user will handle all system rebuilds manually
- Do what has been asked; nothing more, nothing less
- NEVER create files unless they're absolutely necessary for achieving your goal
- ALWAYS prefer editing an existing file to creating a new one
- NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User
