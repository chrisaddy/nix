{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    vlc
    ffmpeg
  ];
}
