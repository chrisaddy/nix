{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  programs.wezterm = {
    enable = true;
  enableZshIntegration = true;
  enableBashIntegration = true;
    extraConfig = ''
local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Batman'

return config
    '';

  };

  programs.tmate.enable = true;
}
