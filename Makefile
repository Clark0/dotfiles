PACKAGES := $(notdir $(wildcard config/*))
TARGET := $(HOME)
FLAKE := $(CURDIR)
HOST ?= Linux

.PHONY: stow unstow darwin-switch hm-switch hm-switch-mac $(PACKAGES)

stow: $(PACKAGES)

$(PACKAGES):
	stow --target=$(TARGET) --dir=config --restow $@

unstow:
	for pkg in $(PACKAGES); do stow --target=$(TARGET) --dir=config --delete $$pkg; done

# Nix
darwin-switch:
	sudo NIX_CONFIG="extra-experimental-features = nix-command flakes" nix run nix-darwin -- switch --flake $(FLAKE)#Macbook

hm-switch:
	NIX_CONFIG="extra-experimental-features = nix-command flakes" nix run home-manager -- switch --flake $(FLAKE)#Linux

hm-switch-mac:
	NIX_CONFIG="extra-experimental-features = nix-command flakes" nix run home-manager -- switch --flake $(FLAKE)#Macbook

hm-update:
	nix flake update $(FLAKE)

hm-gc:
	nix-collect-garbage --delete-older-than 7d

hm-optimise:
	nix store optimise
