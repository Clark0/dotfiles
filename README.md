# Dotfiles Overview

My home-manager & nix-darwin configurations. Meant to work across linux and macOS.

## Layout
Stow owns dotfiles under `stow/`.
Home Manager owns CLI tools and program integrations.
`nix-darwin` owns macOS system settings and Homebrew.

## Flakes
Enable experimental-features
```bash
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

If you wire this into a flake entrypoint, update `specialArgs` there.

## Stow
From the repo root:
```bash
stow -d stow -t ~ alacritty ghostty nix nvim tmux vim zellij zshrc
```

### Nix-darwin
To apply changes to the system
```bash
nix run nix-darwin -- switch --flake .#Macbook
darwin-rebuild switch --flake .#Macbook
```
Note: Homebrew may need to be installed manually.

### Home manager
To apply changes to the home \
For macOS:
```bash
nix run nixpkgs#home-manager -- switch -b bak --flake .#Macbook
```

For Linux
```bash
nix run nixpkgs#home-manager -- switch -b bak --flake .#Linux
```

## Applications
* System apps: [nix-darwin/brew.nix](nix-darwin/brew.nix)
* User packages and integrations: [home-manager/default.nix](home-manager/default.nix)
* Dotfiles configs: [stow](stow/)
