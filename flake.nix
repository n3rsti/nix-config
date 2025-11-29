{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell.inputs.quickshell = {
      url = "github:outfoxxed/quickshell/1ddb355121484bcac70f49edd4bd006b1d3a753e";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs_25_05.url = "github:nixos/nixpkgs/nixos-25.05";

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
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
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/server/configuration.nix
            #inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
