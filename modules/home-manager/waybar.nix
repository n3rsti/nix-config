{ config, pkgs, ... }:

{
programs.waybar = {
  enable = true;
  settings = [
    {
      "layer" = "top";
      "position" = "top";
      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [ "pulseaudio" "network" ];
      "clock" = {
        "format" = "{:%Y-%m-%d %H:%M:%S}";
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-source" = " {volume}%";
        "format-source-muted" =  "";
        "on-click" = "pavucontrol";
        "format-icons" =  {
            "default" =["" "" ""];
        };
      };
    }
  ];
  style = ''
    * {
      font-family: "Fira Code", FontAwesome, sans-serif;
      font-size: 12px;
    }
  '';
};

}
