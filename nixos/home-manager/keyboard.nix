{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    keymapp
  ];
}
