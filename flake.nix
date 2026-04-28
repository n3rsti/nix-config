{
  description = "Nixos config flake";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    awww.url = "git+https://codeberg.org/LGFae/awww";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      nix-minecraft,
      nix-flatpak,
      sops-nix,
      ...
    }@inputs:
    let
      unstableOverlay = final: prev: {
        unstable = import inputs.nixpkgs_unstable {
          system = final.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      };

      mkNixosConfiguration =
        {
          system ? "x86_64-linux",
          baseModules ? [

            inputs.home-manager.nixosModules.default
            chaotic.nixosModules.default
            inputs.nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
            { nixpkgs.overlays = [ unstableOverlay ]; }
            sops-nix.nixosModules.sops

          ],
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = baseModules ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        pc = mkNixosConfiguration {
          extraModules = [
            ./hosts/pc/configuration.nix
          ];
        };

        laptop = mkNixosConfiguration {
          extraModules = [
            ./hosts/laptop/configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
          ];
        };

        server = mkNixosConfiguration {
          baseModules = [
            nix-minecraft.nixosModules.minecraft-servers
            {
              nixpkgs.overlays = [
                inputs.nix-minecraft.overlay
              ];
            }
          ];
          extraModules = [
            ./hosts/server/configuration.nix
          ];
        };
      };
    };
}
