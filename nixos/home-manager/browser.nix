{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nyxt
    freetube
  ];
}
