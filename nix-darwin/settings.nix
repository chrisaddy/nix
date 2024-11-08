let
  colorConfig = import ./colors.nix;
in {
  user = {
    name = "chrisaddy";
  };
  colorscheme = colorConfig.colors.tokyoNight;
  fonts = {
    size = 12;
  };
}
