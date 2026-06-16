{
  description = "Nixos config flake";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pixie-sddm.url = "github:xCaptaiN09/pixie-sddm";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-minecraft,
      nix-flatpak,
      sops-nix,
      flake-parts,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        treefmt-nix.flakeModule
      ];

      perSystem = _: {
        treefmt = {
          projectRootFile = "flake.nix";

          programs.nixfmt.enable = true;
          programs.deadnix.enable = true;
          programs.statix.enable = true;
        };
      };

      flake =
        let
          unstableOverlay = final: _prev: {
            unstable = import inputs.nixpkgs_unstable {
              system = final.stdenv.hostPlatform.system;
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [
                  "electron-39.8.10"
                ];
              };
            };
          };

          defaultBaseModules = [
            inputs.home-manager.nixosModules.default
            inputs.nur.modules.nixos.default
            nix-flatpak.nixosModules.nix-flatpak
            sops-nix.nixosModules.sops

            {
              nixpkgs.overlays = [
                unstableOverlay
              ];
            }
          ];

          mkNixosConfiguration =
            {
              system ? "x86_64-linux",
              extraBaseModules ? [ ],
              extraModules ? [ ],
            }:
            nixpkgs.lib.nixosSystem {
              inherit system;

              specialArgs = {
                inherit inputs;
              };

              modules = defaultBaseModules ++ extraBaseModules ++ extraModules;
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
              extraBaseModules = [
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
    };
}
