{
  config,
  pkgs,
  inputs,
  ...
}: let
  settings = import ./settings.nix;
  colors = settings.colorscheme;
in {
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 10;
      font = "monospace";
      prompt-text = "/ ";
      background-color = "#000A";
      text-color = colors.white;
      selection-color = colors.magenta;
    };
  };
  programs.wlogout = {
    enable = true;
  };
}
