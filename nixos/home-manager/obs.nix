{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-move-transition
      input-overlay
    ];
  };
}
