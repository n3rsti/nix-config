{lib, config, pkgs, ...}:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";
    userName = lib.mkOption {
      default = "n3rsti";
      description = "n3rsti";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
    };
  };
}
