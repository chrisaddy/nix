{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gopls
  ];
}
