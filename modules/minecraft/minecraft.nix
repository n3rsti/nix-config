{
  config,
  pkgs,
  lib,
  ...
}:
let
  # This is the same mkOutOfStoreSymlink used by Home-Manager
  mkOutOfStoreSymlink = path: builtins.path {
    path = path;
    name = baseNameOf path;
  };
in
{
  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_10.override {
        loaderVersion = "0.18.1";
      }; # Specific fabric loader version

      operators = {
          n3rsti = "65ab77f9-70d1-4407-b7e1-6daced14599a";
      };

      symlinks."config/sparsestructures.json5" = ./sparsestructures.json5;

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/dQ3p80zK/fabric-api-0.138.3%2B1.21.10.jar";
              sha512 = "sha512-3HOjZTwplHbR9wy2ksTjWsP2lLOwhz49C3KelS6ZK4eNGo4LHRBJpEKg1IPTBoBzGU8Vr1LqmThURhbiBDPMOA==";
            };
            C2ME = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/uNick7oj/c2me-fabric-mc1.21.10-0.3.5.1.0.jar";
              sha512 = "sha512-TQechyq5EP1lpsnocJxwUBeGJvcSXISTico4OI4ZmVvYdOBx6G5qz2+++qLylP2+vsua+ERKkIuaPeiU2AfE2w==";
            };
            Cloth-config= pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9s6osm5g/versions/qMxkrrmq/cloth-config-20.0.149-fabric.jar";
              sha512 = "sha512-3x2eA0ncZPwIWfF7ZbZ7DXdFomtJBeh/wUjd68AoXeUaMlWEhZnw1e4k9qqwD7rEhJ1Au5BSk26qRS0hbHraYg==";
            };
            Cristellib = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/cl223EMc/versions/ZvMKpvgf/cristellib-fabric-1.21.10-3.0.3.jar";
              sha512 = "sha512-hQbQyvBexFZb8wHckZBzPkBh8KT3l0uFqhP7NdLbdbBEh0bQQneifjChaJEXnKdFA7EppdfojMEZSnJJxqrbnA==";
            };
            DistantHorizons = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uCdwusMi/versions/9Y10ZuWP/DistantHorizons-2.3.6-b-1.21.10-fabric-neoforge.jar";
              sha512 = "sha512-Gxtwt+xikNFSpfn6Py5o6niV9AfFYbVukauj/a3vJ3zSWYeWdhmNZIHcx2oib/GqhXwBrpxBvj6WO1lUYHSh/A==";
            };
            DungeonsAndTaverns = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/tpehi7ww/versions/Fp3HZr0m/dungeons-and-taverns-v5.0.4.jar";
              sha512 = "sha512-YbO1rLYlliMpZYDkaQonJHxrqRspo2w5d+kbkDRUxzqASWVtFlRiUKN7wM2iCDTOnKfcRhFxaz4Jj2eUNqYVHw==";
            };
            FallingTree = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Fb4jn8m6/versions/hDjB8uAg/FallingTree-1.21.10-1.21.10.1.jar";
              sha512 = "sha512-YW02VdD+emtW8rfJc6xF9BOA9o0+XQxiBc8wgv8fNamJXI+K8tPqKnwkQBeErcT8l5tweUql98i8upqVELFDmA==";
            };
            Incendium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/PovCtpuw/Incendium_1.21.x_v5.4.9.jar";
              sha512 = "sha512-BosH6x7uCTS65EMDZXjUBg9UpiTyLyrOsKlTs3KI4KPmdqDXIdJRUelJ5QbufQSBwR9klT/jFZNC8kRuqYSFnA==";
            };
            Tectonic = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/kL6i6vRY/tectonic-3.0.17-fabric-1.21.10.jar";
              sha512 = "sha512-GyPvj1lmHtmp6ORcce+im6h5soYUgtr3x+xByjTUrNLqDs5OcfFrvkYIPH1bxAtNjoKX1LAUKkEzNHw58iOzcg==";
            };
            Terralith= pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/JKg71Gq0/Terralith_1.21.x_v2.5.13.jar";
              sha512 = "sha512-MQOHnvOQ1Hpo8QvUvxudQGOWkFr6ZAuMFcOkTIwVu8PG/cTqtalGtr4ViFExQI9s1pjEqNIGUUSyqxxG+nEM2w==";
            };
            Nullscape = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/3fv8O3xX/Nullscape_1.21.x_v1.2.14.jar";
              sha512 = "sha512-s1qd/ccYDKhRrqN47kaH4Ys6rnF8FocKd2Kvxn3Ax3WY+yxKYssS1u0OrPfJFmUg4KPn3OINoJgXBl0n5iyLRA==";
            };
            PlaceholderApi = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/eXts2L7r/versions/T5pDJV1K/placeholder-api-2.8.1%2B1.21.10.jar";
              sha512 = "sha512-kmBmQEV5MWmPJy5OiGa1NXdnNg54o+7Ys71JDooXv+rv3AvURKyLpPUbf58et/IjN+A0tAmTnbNgEmnUtTrSLA==";
            };
            SparseStructures = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/qwvI41y9/versions/xqUgclGq/sparsestructures-fabric-1.21.10-3.1.jar";
              sha512 = "sha512-v+MM+la7aHyaIHFCJAVweRpRm4tN6+lsc/xTcoY5dKM5DhjFVj5NufxBox81sr3AcqOst0Le+mWkJq5YuX8CIg==";
            };
            Structory = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/aKCwCJlY/versions/qm2RM1eD/Structory_1.21.x_v1.3.12.jar";
              sha512 = "sha512-jfluy8BTgPmWmiO8MirsC18S/nWHPwLL9NC9hV3LglT9D5pEj9/a6hYDguf+nMaOASKgEBkXnOyEbHd/9xiKxw==";
            };
            TownsAndTowers = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/DjLobEOy/versions/NXAdx4ui/t_and_t-fabric-neoforge-1.13.7.jar";
              sha512 = "sha512-fv6nWap7WceXf+Lh0YmkF4kryi/bq8DlR+qSFCXN5fJi6YJVb8g9AgmRBifcNJ5XzVQuct0Hg8rIx8QiGLezaw==";
            };
            TradeCycling = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/qpPoAL6m/versions/bWRFCmCA/trade-cycling-fabric-1.21.10-1.0.19.jar";
              sha512 = "sha512-rO1Mlv5vauflgSHSP5mx0S4FzxOcWiFd8p4GXKxK4AVmA2ELrlxw+jYErCT+Ls8SPRQRg7q7BetiNnS/QkqADg==";
            };
            Lithostiched= pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XaDC71GB/versions/OHVYggvo/lithostitched-1.5.1-fabric-1.21.9.jar";
              sha512 = "sha512-6Xt7zZi8JjB1iYIsmOJOSgx7hZ8EYe2BBAElBobHugDtfp6JhCuXFM4NyB2jMELFY9nxGn4D2pA2hUCF835RYw==";
            };
            WWOO = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/II7t6llZ/versions/qCxyIvl0/wwoo-fabric-2.6.0.jar";
              sha512 = "sha512-LcoEtdd0DqXGtuzTUc/4hYGI2iZbzNZHeFxfq7UfYWYbq5Zm3KoNeJB5DxXI5L6eaYcel6z9nJCA6yK/W0Co5w==";
            };
	    
          }
        );
      };
    };
  };
}
