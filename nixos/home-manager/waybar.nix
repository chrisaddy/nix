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
          border: none;
          border-radius: 0;
          font-family: Liberation Mono;
          min-height: 20px;
      }

      window#waybar {
          background: transparent;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces {
          margin-right: 8px;
          border-radius: 10px;
          transition: none;
          background: transparent;
      }

      #workspaces button {
          transition: none;
          color: #7c818c;
          background: transparent;
          padding: 5px;
          font-size: 18px;
      }

      #workspaces button.persistent {
          color: #7c818c;
          font-size: 12px;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          border-radius: inherit;
          color: #383c4a;
          background: #7c818c;
      }

      #workspaces button.focused {
          color: white;
      }

      #mode {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: transparent;
      }

      #clock {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px 0px 0px 10px;
          transition: none;
          color: #ffffff;
          background: transparent;
      }

      #backlight {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: transparent;
      }

      #battery {
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: transparent;
      }

      #battery.charging {
          color: #ffffff;
          background-color: transparent
      }

      #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #tray {
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 10px;
          transition: none;
          color: #ffffff;
          background: transparent;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
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
          "worspaces"
        ];
        modules-center = ["clock"];
        modules-right = [
          "battery"
          "tray"
        ];

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
    };
  };
}
