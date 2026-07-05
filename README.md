# Dotfiles

Home-manager & nix-darwin configurations for Linux and macOS.

## Quick start

```bash
make stow            # symlink configs to ~
make hm-switch       # activate home-manager (Linux)
make darwin-switch   # activate nix-darwin + home-manager (macOS, needs sudo)
make hm-switch-mac   # activate home-manager only (macOS, no sudo)
```

## Layout

```
config/           # stow packages (~/.config/<app>)
  alacritty/
  ghostty/
  nix/
  nvim/
  tmux/
  vim/
  zellij/
  zsh/
home-manager/     # nix home-manager configs
nix-darwin/       # macOS system configs
```

## Makefile

| Target | Description |
|---|---|
| `make stow` | Symlink all configs to `~` |
| `make unstow` | Remove symlinks |
| `make darwin-switch` | Activate nix-darwin + home-manager (macOS, needs sudo) |
| `make hm-switch` | Activate Linux home-manager |
| `make hm-switch-mac` | Activate macOS home-manager only (no sudo) |
| `make hm-update` | Update flake inputs |
| `make hm-gc` | GC nix store (>30d old) |
| `make hm-optimise` | Deduplicate nix store |

## Manual commands

nix-darwin (macOS, full system):
```bash
nix run nix-darwin -- switch --flake .#Macbook
```

Home-manager only (macOS, no sudo):
```bash
home-manager switch --flake .#Macbook
```

Home-manager (Linux):
```bash
home-manager switch --flake .#Linux
```

## Configs

- **System apps:** [nix-darwin/brew.nix](nix-darwin/brew.nix)
- **User packages:** [home-manager/default.nix](home-manager/default.nix)
- **Dotfiles:** [config/](config/)
