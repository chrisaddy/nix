{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.nyxt = {
    enable = true;
    configDir = "${config.xdg.configHome}/nyxt";
  };
}
