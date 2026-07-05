PACKAGES := $(notdir $(wildcard config/*))
TARGET := $(HOME)
FLAKE := $(CURDIR)
HOST ?= Linux

.PHONY: stow unstow $(PACKAGES)

stow: $(PACKAGES)

$(PACKAGES):
	stow --target=$(TARGET) --restow config/$@

unstow:
	for pkg in $(PACKAGES); do stow --target=$(TARGET) --delete config/$$pkg; done

# Nix
hm-switch:
	$(if $(filter Macbook,$(HOST)),darwin-rebuild switch,home-manager switch) --flake $(FLAKE)#$(HOST)

hm-update:
	nix flake update $(FLAKE)

hm-gc:
	nix-collect-garbage --delete-older-than 30d

hm-optimise:
	nix store optimise
