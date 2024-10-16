{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    graphite-cli
  ];

  programs = {
    git = {
      enable = true;
      userName = "chrisaddy";
      userEmail = "chris.william.addy@gmail.com";
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
    gh-dash.enable = true;
    git-cliff.enable = true;
    lazygit.enable = true;
  };
}
