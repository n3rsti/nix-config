{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        "layer" = "top";
        "position" = "top";

        "modules-left" = [
          "hyprland/workspaces"
        ];
        "modules-center" = [
          "clock"
        ];
        "modules-right" = [
          "hyprland/language"
          "network"
          "pulseaudio"
          "custom/powermenu"
        ];

        "clock" = {
          "format" = "{:%B %d   %H:%M}";
        };

        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          "on-click" = "pavucontrol";
        };

        "network" = {
          "format-wifi" = "   {essid} ({signalStrength}%)";
          "format-ethernet" = "{ipaddr}/{cidr}   ";
          "tooltip-format" = "{ifname} via {gwaddr}   ";
          "format-linked" = "{ifname} (No IP)   ";
          "format-disconnected" = "Disconnected   ⚠";
        };

        "custom/powermenu" = {
          "format" = "⏻";
          "tooltip" = "Power Menu";
        };

        "hyprland/language" = {
          "format" = "    {}";
          "format-en" = "EN";
          "format-pl" = "PL";
        };
      }
    ];

    style = ''
      * {
        font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 12px;
      }

      #waybar {
        background: rgba(25, 27, 38, 0.75);
        color: #c0caf5;
        font-family: "SpaceMono Nerd Font", feather;
      }

      #clock, #network, #pulseaudio, #custom-powermenu, #hyprland-language {
        padding: 0 10px;
        border-radius: 13px;
      }

      .modules-left, .modules-center, .modules-right {
        background: rgba(0, 0, 8, 0.7);
        padding: 0 5px;
        margin: 5px 10px;
        border-radius: 13px;
      }

      #workspaces button {
        background: transparent;
        font-weight: 900;
        font-size: 13pt;
        color: #c0caf5;
        border: none;
        border-radius: 13px;
      }
    '';
  };
}
