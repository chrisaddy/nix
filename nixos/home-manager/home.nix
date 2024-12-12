{
  config,
  pkgs,
  username,
  inputs,
  ...
}: let
  settings = import ./settings.nix;
  user = settings.user;
in {
  imports = [
    ./books.nix
    ./browser.nix
    ./c.nix
    ./discord.nix
    ./emacs.nix
    ./email.nix
    ./git.nix
    ./go.nix
    ./k8s.nix
    ./nix.nix
    ./hyprland.nix
    #./hyprpaper.nix
    ./learning.nix
    ./lua.nix
    ./menu.nix
    ./notes.nix
    ./obs.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./sway.nix
    ./terminal.nix
    ./video.nix
    ./vim.nix
    ./waybar.nix
  ];
  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "23.11";
    packages = with pkgs; [
    ];
  };

  programs.home-manager = {
    enable = true;
  };
  programs.ripgrep.enable = true;

  nix = {
    gc = {
      automatic = true;
      frequency = "daily";
    };
  };
}
