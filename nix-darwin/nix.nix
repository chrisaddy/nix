{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nh

    (writeShellScriptBin "update" ''
      pushd ${config.xdg.configHome}/nix-darwin
      ${pkgs.broot}/bin/broot
      ${pkgs.alejandra}/bin/alejandra .

      sudo nix flake update
      darwin-rebuild switch --flake ~/.config/nix-darwin
      exec $SHELL
    '')
  ];
}
