{ inputs, ... }:
{
  flake.nixosModules.minecraft =
    { pkgs, ... }:
    {
      imports = [
        inputs.nix-minecraft.nixosModules.minecraft-servers
      ];

      nixpkgs.overlays = [
        inputs.nix-minecraft.overlay
      ];

      services.borgbackup.jobs.minecraft-backup = {
        paths = "/srv/minecraft/fabric";
        encryption.mode = "none";
        environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
        repo = "u557087@u557087.your-storagebox.de:./backups/fabric";
        compression = "auto,zstd";
        startAt = "daily";
        prune.keep = {
          within = "3d";
          daily = 7;
          weekly = 2;
        };
      };

      # Minecraft server settings
      services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers.fabric = {
          serverProperties = {
            spawn-protection = 0;
            difficulty = 3;
            white-list = true;
          };
          enable = true;
          jvmOpts = "-Xms2G -Xmx8G -XX:+UseZGC -XX:+DisableExplicitGC";

          package = pkgs.fabricServers.fabric-26_3.override {
            loaderVersion = "0.19.5";
            jre_headless = pkgs.openjdk25_headless;
          };

          operators = {
            n3rsti = "65ab77f9-70d1-4407-b7e1-6daced14599a";
          };

          symlinks."config/sparsestructures.json5" = ./sparsestructures.json5;

          files."config/DistantHorizons.toml" = ./DistantHorizons.toml;

          symlinks."allowed_symlinks.txt" = pkgs.writeText "allowed_symlinks.txt" "/nix/store";

          symlinks = {
            mods = pkgs.linkFarmFromDrvs "mods" (
              builtins.attrValues {
                DistantHorizons = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/uCdwusMi/versions/TGgEbP9A/DistantHorizons-3.3.4-26.3-fabric-neoforge.jar";
                  sha512 = "sha512-C5CxsI2Zl0v8PI6Gss6yUuL5FxXtZrklAEwoM1+0Thvdu7a4BD5NTVPIftJHeJzReIsbpOP0OU7+FU4MWc/yNg==";
                };
                Fabric-API = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/v2j28coa/fabric-api-0.162.0%2B26.3.jar";
                  sha512 = "sha512-WrcJCJUvHSNG0WsSLKMTJ/QFXbWcJ5obw8PFgc41m7VBy6FXMPVbBye+fHxN68SkQSoYPCKODU3qgcc097QSzg==";
                };
                C2ME = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/VSNURh3q/versions/ODMLK8M9/c2me-fabric-mc26.3-0.4.2-alpha.0.90.jar";
                  sha512 = "sha512-0BQOva0it+4ALE4XaF27JU1mdWKEAADvmM7auvpTvGfRARufxNcPJvlk/HgTc+YVg9ObAB5+FWRLqX3RnqHCzg==";
                };
                Cloth-config = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/9s6osm5g/versions/fg2uyxOW/cloth-config-fabric-26.3.159.jar";
                  sha512 = "sha512-iSThnUGEUJZyT6EPNxe8UZZKDtu7ytD/Hmxhh6OYsI81bklXmmV8LcRKf5LjhQdx88pwv4wfZU3mBCUWO5HbsQ==";
                };
                Cristellib = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/cl223EMc/versions/rWxmPrGC/cristellib-fabric-26.3-3.1.13.jar";
                  sha512 = "sha512-lhmN/AZ85wA8rZshEobljjbvyqKXKa88CcZD0+i9ilTlgU642IaAo4yvnmMopUEVG2xrG9msEX2ccnjZPW3ojA==";
                };
                DungeonsAndTaverns = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/tpehi7ww/versions/WilF7nqU/dungeons-and-taverns-6.0.2.jar";
                  sha512 = "sha512-sMz1JRJWCoEVs1bFo+WFxxlmrxByny1DZBryaCWCcrufnGjFPEnreaXV9kW6ng3/bkritlTq9qbRRpd95DXAJQ==";
                };
                FallingTree = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/Fb4jn8m6/versions/AAGlDV9D/FallingTree-26.3-25.jar";
                  sha512 = "sha512-BxNIJvbW4BIyz0yWuh/8UptD2TvjwYohW6OvhXIoKmsE4xdffcWDFHH2cirUpPkWHUMgNQdhfDtsQ5CMUOfvIQ==";
                };
                Incendium = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/vMABj7fb/Incendium_26.3_v5.5.3%2B26.3.jar";
                  sha512 = "sha512-VYIu+xevjmeEk0HiAhrSCGpWTJ5+ljjMiHtSP/VrRuRVCesedd9b6wGaIQlB9uyRf7+OBsYO0pPF0PjRePTDqQ==";
                };
                Tectonic = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/j2jmkU85/tectonic-3.0.31-fabric-26.3.jar";
                  sha512 = "sha512-itvZHuPnySVGXviDZ846E72ViDi53x6LqePwxecZcZR170hEkbkxlJFIAMxbdSMQTLCUUmGb8wdVXGSfXS4CvA==";
                };
                Terralith = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/aGE3hYAA/Terralith_26.3_v2.6.5%2B26.3.jar";
                  sha512 = "sha512-kYsjLfeoVbronH+oWv+1zhNOI2xHJvoUpb2qF56x4BDwQKn6mB8Aag4m5CGiqWG8KademaRQD9GDYai6gUeAcQ==";
                };
                Nullscape = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/79OyFQtd/Nullscape_26.3_v2.0.1%2B26.3.jar";
                  sha512 = "sha512-roSUb9amLqCGPLyf0nZq0IY1qFbS4Vr4Ya99AIB8mOYG0aKgbrF26mJ1AxtmtqGGskXHpAl3l9PBIkTKmk/paA==";
                };
                PlaceholderApi = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/eXts2L7r/versions/lXytLqWj/placeholder-api-3.2.0%2B26.3.jar";
                  sha512 = "sha512-6yuzHlEGiq0lgbeGTqexGxIJuhwrJ1Uc1YN9mzErgYtzu0fAY3S0a5m3NAHGLGtsEV9wLFWu1q/UZ62K1kSN5A==";
                };
                SparseStructures = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/qwvI41y9/versions/pDwhgAWy/sparsestructures-fabric-26.3-3.1.5.jar";
                  sha512 = "sha512-OV1MlxkKg46vrbTu8w1WQ7Ra+qQmIvUiWYoLg8EacapdIhOWX8UErhVxjQzOwJvt2JkYFKg6hpokHJwbCQWkyw==";
                };
                Structory = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/aKCwCJlY/versions/GjOkOVW4/Structory_26.3_v1.3.18%2B26.3.jar";
                  sha512 = "sha512-qbfHzkWjjEvmhWMzfkE62/SGqOR/7MRQ0+5Z2t+Af67jnUmgmMLb/CpGbw02xxyo4FHxYe/b/BmwafDHDmtCIw==";
                };
                TownsAndTowers = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/DjLobEOy/versions/yajFnGZS/t_and_t-fabric-neoforge-1.13.12.jar";
                  sha512 = "sha512-Z3Q5G4c9AkFTi+Kc9/gpnr+vLZ8DKSsoED3/QfztID3GnmQDLKm5njtTZN4hafZUpmM6JVRlrcmU2xesCkwz2A==";
                };
                TradeCycling = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/qpPoAL6m/versions/URzCi2W4/trade-cycling-fabric-1.0.22%2B26.3.jar";
                  sha512 = "sha512-RU39fwyJFV2sDdwrG9aUhsQ50nohSA2P9trEbB47eAngrigQG9MfuGmZmsKvpYwrjxUwRrhflUXO5DKuOWssrA==";
                };
                Lithostiched = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/XaDC71GB/versions/ekwE8Gez/lithostitched-2.0.5-fabric-26.3.jar";
                  sha512 = "sha512-TP825gk+rUVsVIG823JycWWmRHxJTkL0SwbEfe7k9vgWQ0kOTU3Xfpt39vxed3GZYggE820Jo9ZsY7xbLw/HbA==";
                };
                WWOO = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/II7t6llZ/versions/23VeM3qz/wwoo-fabric-26.3-3.0.1.jar";
                  sha512 = "sha512-flqhEDSm3tBOzhaMAxdTs+RkpVg1tz/UaBX7KDOy1UHPNi1dDcOE+J3I3Fr+f7t4SNJkxCko+4ZaSPTmsjPMTw==";
                };
                Sleep = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/WTzuSu8P/versions/qWXoHji5/sleep-v4.4.0.0.jar";
                  sha512 = "sha512-RW0/RehKDse0uOKWBYj/NKP7g10C0+cC1Lbz//2yOCOV93hgrCmYPH3ZJD2cQtEXJWOdSnw7ahOOJc0MHsy7zA==";
                };
              }
            );
          };
        };
      };
    };
}
