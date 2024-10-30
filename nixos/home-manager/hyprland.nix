{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
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
        allow_tearing = false;
        gaps_in = "5";
        gaps_out = "20";
        border_size = "2";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };

      windowrulev2 = [
        "move 100 100,class:(mpv),title:(mpv),float,size 10 10"
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        #"fakefullscreen,class:^(firefox)$,title:^(Picture-in-Picture)$"
        # firefox figma micro indicator
        #"fakefullscreen,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        "float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
      ];

      # firefox Picture-in-Picture
      windowrule = [
        # "workspace 1 silent,firefox"
        "center,^(task-floating)$"
        "float,^(task-floating)$"
        "dimaround,^(task-floating)$"
        "noborder,^(task-floating)$"
      ];

      dwindle = {
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
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
        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      # misc = {
      #   force_default_wallpaper = "0";
      #   disable_hyprland_logo = "yes";
      # };
      #
      bind = [
        "$mod, Return, exec, foot"
        "$mod, R, exec, rio"
        "$mod, A, exec, griZ -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        "$mod, B, exec, nyxt"
        "$mod, C, killactive,"
        "$mod, D, exec, discord"
        "$mod, E, exec, emacs"
        "$mod, G, exec, google-chrome-stable"
        "$mod, M, exec, tofi-drun | xargs hyprctl dispatch exec --"
        "$mod, O, exec, obs"
        "$mod, P, pseudo, dwindle"
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, Q, exec, wlogout"
        "$mod, V, togglefloating,"
        "$mod SHIFT, right, resizeactive, 10 0"
        "$mod SHIFT, left, resizeactive, -10 0"
        "$mod SHIFT, up, resizeactive, 0 -10"
        "$mod SHIFT, down, resizeactive, 0 10"

        "$mod CONTROL, right, movewindowpixel, 10 0"

        # windows
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ];
    };

    #
    # # Example per-device config
    # # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    # device:epic-mouse-v1 {
    #     sensitivity = -0.5
    # }
    #
    # # Example windowrule v1
    # # windowrule = float, ^(kitty)$
    # # Example windowrule v2
    # # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    #
    #
    # # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    #
    # # Switch workspaces with mainMod + [0-9]
    # # Move active window to a workspace with mainMod + SHIFT + [0-9]
    #
    # # Example special workspace (scratchpad)
    #
    # # Scroll through existing workspaces with mainMod + scroll
    # bind = $mainMod, mouse_down, workspace, e+1
    # bind = $mainMod, mouse_up, workspace, e-1
    #
    # # Move/resize windows with mainMod + LMB/RMB and dragging
    # bindm = $mainMod, mouse:272, movewindow
    # bindm = $mainMod, mouse:273, resizewindow
    # };
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
  };
}
