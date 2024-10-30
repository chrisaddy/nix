{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
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
    ./hyprpaper.nix
    ./lua.nix
    ./menu.nix
    ./notes.nix
    ./obs.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./terminal.nix
    ./video.nix
    ./vim.nix
    ./waybar.nix
  ];
  home = {
    username = "chrisaddy";
    homeDirectory = "/home/chrisaddy";
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
