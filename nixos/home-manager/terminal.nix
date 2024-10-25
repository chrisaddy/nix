{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=18";
        dpi-aware = "yes";
      };
      environment = {
        name = "aion";
      };
      url = {launch = "xdg-open \${url}";};
      mouse = {hide-when-typing = "yes";};
    };
  };
  programs.rio = {
    enable = true;
    settings = {
      theme = "Dracula";
    };
  };

  programs.tmate.enable = true;
}
