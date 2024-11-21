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
      terminal "${pkgs.foot}/bin/foot";
      menu = "${pkgs.tofi}/bin/tofi";
      workspaceLayout = "default";
      gaps = {
        inner = 5;
	outer = 3;
      };
      window = {
        border = 2;
	titlebar = false;
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
	in lib.mkOptionDefault {
     	  "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
	};

	extraPackages = {
	  swaylock
	  swayidle
	  i3status
	  mako
	  wl-clipboard
	};
	
      };
    };
  };
}
