{
  config,
  pkgs,
  lib,
  username,
  inputs,
  ...
}: let
  settings = import ./settings.nix;
in {
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.tofi}/bin/tofi";
      workspaceLayout = "default";
      gaps = {
        inner = 5;
        outer = 20;
      };
      bars = [];
      window = {
        border = 2;
        titlebar = false;
      };
      startup = [
        {command = "swaymsg workspace 1";}
        {command = "waybar";}
        {command = "${pkgs.swaybg}/bin/swaybg -i ~/.config/wallpapers/drive.jpg -m fill";}
      ];
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
          "${modifier}+a" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" /screenshots/$(date +%Y-%m-%d_%H-%Ma-%S).png";
          "${modifier}+b" = "exec ${pkgs.nyxt}/bin/nyxt";
          "${modifier}+Shift+b" = "exec ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
          "${modifier}+c" = "kill";
          "${modifier}+d" = "exec ${pkgs.discord}/bin/discord";
          "${modifier}+g" = "exec google-chrome-stable";
          "${modifier}+l" = "exec thunderbird";
          "${modifier}+o" = "exec obs";
          "${modifier}+t" = "exec tofi-drun | xargs swaymsg exec --";
          "${modifier}+q" = "exec wlogout";
          "${modifier}+w" = "exec emacs";
          "${modifier}+y" = "exec freetube";

          # window management
          "${modifier}+u" = "workspace prev";
          "${modifier}+comma" = "workspace next";
          "${modifier}+Shift+u" = "move container to workspace prev";
          "${modifier}+Shift+comma" = "move container to workspace next";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 0";

          "${modifier}+s" = "scratchpad show";
          "${modifier}+Shift+s" = "move scratchpad";

          "${modifier}+p" = "layout toggle split";
          "${modifier}+m" = "focus left";
          "${modifier}+Shift+m" = "resize shrink width 10px";

          "${modifier}+n" = "focus down";
          "${modifier}+Shift+n" = "resize grow height 10px";

          "${modifier}+e" = "focus up";
          "${modifier}+Shift+e" = "resize shrink height 10px";
          "${modifier}+i" = "focus right";
          "${modifier}+Shift+i" = "resize grow width 10px";
          "${modifier}+v" = "floating toggle";

          "${modifier}+Control+Right" = "move right 10px";
        };
    };

    # extraPackages = with pkgs; [
    #   swaylock
    #   swayidle
    #   i3status
    #   mako
    #   wl-clipboard
    # ];
  };
}
