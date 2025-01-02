{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cargo
    rustc
  ];

  home.file."kanata.kbd".text = ''
    (defsrc
      caps
      esc)
    (deflayer base
      esc
      caps)
  '';
}
