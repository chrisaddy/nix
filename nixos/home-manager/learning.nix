{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
  ];

  programs.anki = {
    enable = true;
  };
}
