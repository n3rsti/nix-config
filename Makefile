.PHONY: switch test boot build update generate-hardware-config remote-switch

HOST_REQUIRED_TARGETS := switch test boot build remote-switch

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

remote-switch:
	nixos-rebuild switch --flake .#$(HOST) \
		--target-host n3rsti@$(HOST) \
		--sudo \
		--ask-sudo-password

generate-hardware-config:
	sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

update:
	nix flake update
