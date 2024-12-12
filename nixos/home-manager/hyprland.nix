{
  config,
  pkgs,
  username,
  inputs,
  ...
}: let
  settings = import ./settings.nix;
  colors = settings.colorscheme.hyprland;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "waybar & hyprpaper"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      "$mod" = "SUPER";

      monitor = ",preferred,auto,auto";

      general = {
        allow_tearing = true;
        gaps_in = "5";
        gaps_out = "20";
        border_size = "2";
        "col.active_border" = "${colors.border.active} 45deg";
        "col.inactive_border" = colors.border.inactive;
      };

      windowrule = [
        "center,^(task-floating)$"
        "float,^(task-floating)$"
        "dimaround,^(task-floating)$"
        "noborder,^(task-floating)$"
      ];

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = "0";
      };

      decoration = {
        rounding = "10";
        blur = {
          enabled = true;
          size = "3";
          passes = "1";
        };
        # drop_shadow = "yes";
        # shadow_range = "4";
        # shadow_render_power = "3";
        # "col.shadow" = colors.col.shadow;
      };

      animations = {
        enabled = "no";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier, slidevert"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      misc = {
        force_default_wallpaper = "0";
        disable_hyprland_logo = "yes";
      };

      bind = [
        # applications
        "$mod, Return, exec, foot"
        "$mod, A, exec, griZ -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        "$mod, B, exec, nyxt"
        "$mod, D, exec, discord"
        "$mod, W, exec, emacs"
        "$mod, G, exec, google-chrome-stable"
        "$mod, T, exec, tofi-drun | xargs hyprctl dispatch exec --"
        "$mod, O, exec, obs"
        "$mod, Y, exec, freetube"
        "$mod, C, killactive,"
        "$mod, Q, exec, wlogout"

        # window navigation
        "$mod, U, workspace, -1"
        "$mod, comma, workspace, +1"
        "$mod SHIFT, U, movetoworkspace, -1"
        "$mod SHIFT, comma, movetoworkspace, +1"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        "$mod, P, pseudo, dwindle"

        "$mod, M, movefocus, l"
        "$mod SHIFT, M, resizeactive, -10 0"

        "$mod, N, movefocus, d"
        "$mod SHIFT, N, resizeactive, 0 10"

        "$mod, E, movefocus, u"
        "$mod SHIFT, E, resizeactive, 0 -10"

        "$mod, I, movefocus, r"
        "$mod SHIFT, I, resizeactive, 10 0"

        "$mod, V, togglefloating,"

        "$mod CONTROL, right, movewindowpixel, 10 0"
      ];
    };

    plugins = [
    ];
  };
}
