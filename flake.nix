{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      nix-minecraft,
      nix-flatpak,
      ...
    }@inputs:
    {
      # Default configuration (can be used for testing or as a base)
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            chaotic.nixosModules.default
            inputs.walker.nixosModules.default
            inputs.nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
          ];

        };

        # PC-specific configuration
        pc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc/configuration.nix
            inputs.home-manager.nixosModules.default
            chaotic.nixosModules.default
            inputs.walker.nixosModules.default
            inputs.nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };

        # Laptop-specific configuration
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
            chaotic.nixosModules.default
            inputs.nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/server/configuration.nix
            nix-minecraft.nixosModules.minecraft-servers
            {
              nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
            }
            #inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
