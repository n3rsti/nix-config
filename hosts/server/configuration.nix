{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/minecraft/minecraft.nix
    ../../modules/builder/remote-builder.nix
    ./backups.nix
    ./sops.nix
    ./services.nix
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
        "root"
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

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
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
      ];
    };

    groups.media = { };
  };

  environment.systemPackages = with pkgs; [
    vim
    nano
    neovim
    git
    ghostty
    jdk25
    btop
    tmux
    go
    docker
    qbittorrent-nox
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
  ];

  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    firewall = {
      checkReversePath = "loose"; # Tailscale issue fix
      allowedTCPPorts = [
        25565
        8096
        8082
        80
        443
        47990
        8443
        28981
      ];
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
