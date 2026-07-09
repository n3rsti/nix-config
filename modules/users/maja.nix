{
  flake.nixosModules.maja = _: {
    users.users.Maja = {
      isNormalUser = true;
      description = "Maja";
      extraGroups = [
        "networkmanager"
        "gamemode"
      ];
    };
  };
}
