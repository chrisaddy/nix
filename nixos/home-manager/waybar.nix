{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    font-awesome
  ];

  programs.waybar = {
    enable = true;
    style = ''
         * {
             font-size: 20px;
             font-family: monospace;
             color: #fdf6e3;
      margin-top: 0;
         }
         window#waybar {
           background-color: transparent;
         }
         #workspaces button.focused {
           background: rgba(180, 180, 180, 0.5);
         }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        width = 1280;
        margin = "0 0 0 0";
        modules-left = [
          "sway/workspaces"
        ];
        modules-center = ["clock"];
        modules-right = [
          "battery"
          "tray"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          format = "{name}";
        };

        clock = {
          timezone = "America/New_York";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%a, %d %b, %I:%M %p}";
        };
      };
      pulseaudio = {
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = "婢 {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["奄" "奔" "墳"];
        };
        on-click = "pavucontrol";
        min-length = 13;
      };
      cpu = {
        interval = 5;
        format = "cpu {usage:2}%";
      };
    };
  };
}
