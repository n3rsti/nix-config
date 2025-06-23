# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/main-user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.user.services.qbittorrent-nox = {
    description = "qBittorrent-nox Web UI";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      Restart = "on-failure";
    };
  };
  virtualisation.docker.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "n3rsti" = { pkgs, ... }: {
        imports = [ ./home.nix ];
      };
    };
    # This allows specific host configurations to override home-manager settings
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  main-user.enable = true;
  main-user.userName = "n3rsti";



  services.openssh = {
    enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.zsh.enable = true;
  services.jellyfin = {
    user = "n3rsti";
    enable = true;
    openFirewall = true;
  };
  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "n3rsti";
    group = "users";
    dataDir = "/home/n3rsti/radarr";
  };

  services.ombi = {
    enable = true;
    openFirewall = true;
    user = "n3rsti";
    group = "users";
    dataDir = "/home/n3rsti/ombi";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/home/n3rsti/prowlarr";
  };

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
  };


  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "n3rsti";
    group = "users";
    dataDir = "/home/n3rsti/sonarr";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n3rsti = {
    isNormalUser = true;
    description = "n3rsti";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  vim
  nano
  kitty
  neovim
  git
  ghostty
  jdk
  btop
  tmux
  go
  docker
  jellyfin
  jellyfin-web
  jellyfin-ffmpeg
  qbittorrent-nox
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 25565 8096 8082 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
