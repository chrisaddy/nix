{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "clean-system" ''      sudo nix-collect-garbage --delete-older-than 15d --verbose nix store optimise --verbose
           nix store gc --verbose
    '')

    (writeShellScriptBin "update" ''
      pushd ${config.xdg.configHome}/nixos
      ${pkgs.broot}/bin/broot
      ${pkgs.alejandra}/bin/alejandra .

      sudo nix flake update
      ${pkgs.nh}/bin/nh os switch --update . --hostname aion
      exec $SHELL
    '')
  ];
}
