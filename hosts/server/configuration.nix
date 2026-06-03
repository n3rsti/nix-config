{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/minecraft-server/minecraft.nix
    ../../modules/nixos/builder/remote-builder.nix
    ./backups.nix
    ../../modules/nixos/sops.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/networking/tailscale/default.nix
    ../../modules/nixos/services/arr.nix
    ../../modules/nixos/services/nextcloud.nix
    ../../modules/nixos/services/immich.nix
    ../../modules/nixos/services/paperless.nix
    ../../modules/nixos/services/uptime-kuma.nix
    ../../modules/nixos/openssh.nix
    ./sops.nix
    inputs.home-manager.nixosModules.default
    inputs.sops-nix.nixosModules.sops
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel = {
      sysctl."net.ipv4.ip_forward" = 1;
      sysctl."net.ipv6.conf.all.forwarding" = 1;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [
        "n3rsti"
      ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "n3rsti" =
        { pkgs, ... }:
        {
          imports = [ ./home.nix ];
        };
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  programs = {
    ssh = {
      startAgent = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
    };

    zsh.enable = true;
  };

  users = {
    users.n3rsti = {
      isNormalUser = true;
      description = "n3rsti";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "media"
      ];

      openssh.authorizedKeys.keyFiles = [
        ../../keys/id_pc.pub
        ../../keys/id_laptop.pub
      ];
    };

    groups.media = { };
  };

  environment.systemPackages = with pkgs; [
    nano
    neovim
    git
    ghostty
    jdk25
    btop
    tmux
    go
    docker
    wakeonlan
    nmap
    eza
    zip
    unzip
    tree
    nixfmt
    age
    sops
    ripgrep
    devenv
    jq
  ];

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    firewall = {
      allowedTCPPorts = [ ];
    };

  };

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
