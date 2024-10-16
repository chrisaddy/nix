{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/wallpapers/drive.jpg"
      ];
      wallpaper = [
        "DP-1,~/.config/wallpapers/drive.jpg"
      ];
      splash = true;
    };
  };
}
