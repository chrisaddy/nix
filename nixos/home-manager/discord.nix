{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    discord
  ];
}
