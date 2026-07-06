.PHONY: switch test boot build update generate-hardware-config

HOST_REQUIRED_TARGETS := switch test boot build

ifneq ($(filter $(MAKECMDGOALS),$(HOST_REQUIRED_TARGETS)),)
ifndef HOST
$(error HOST is not defined. Use: make switch HOST=pc)
endif
endif

switch:
	sudo nixos-rebuild switch --flake .#$(HOST)

test:
	sudo nixos-rebuild test --flake .#$(HOST)

boot:
	sudo nixos-rebuild boot --flake .#$(HOST)

build:
	nixos-rebuild build --flake .#$(HOST)

generate-hardware-config:
	sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

update:
	nix flake update
