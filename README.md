# Dotfiles Overview

My home-manager & nix-darwin configurations. Meant to work across linux and macOS.

## Flakes
Enable experimental-features
```bash
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Update `specialArgs` in [flake.nix](flake.nix).

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
* User apps: [home-manager/default.nix](home-manager/default.nix)
* Dotfiles configs: [home-manager/config](home-manager/config/)
