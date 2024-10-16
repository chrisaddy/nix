{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nh
    lf
    (writeShellScriptBin "clean-system" ''      sudo nix-collect-garbage --delete-older-than 15d --verbose nix store optimise --verbose
           nix store gc --verbose
    '')

    (writeShellScriptBin "update" ''
      ${pkgs.alejandra}/bin/alejandra ${config.xdg.configHome}/nixos

      nh os switch --update ${config.xdg.configHome}/nixos/ --hostname aion
      exec $SHELL
    '')
  ];
}
