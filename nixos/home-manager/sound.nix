{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    pwvucontrol
    rmpc
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/music";
  };
}
