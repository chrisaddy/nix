{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config".text = ''
    cursor-style = block
    font-size = 24pt
    theme = Argonaut
  '';

  programs.tmate.enable = true;
}
