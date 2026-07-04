{
  flake.nixosModules.maja =
    { pkgs, ... }:
    {
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
