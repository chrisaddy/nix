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

      ./update.sh
    '')
  ];
}
