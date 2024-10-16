{
  config,
  inputs,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    rustup
    cargo
    rust-analyzer
  ];
}
