{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  imports = [
    ./c.nix
    ./discord.nix
    ./emacs.nix
    ./email.nix
    ./foot.nix
    ./git.nix
    ./go.nix
    ./k8s.nix
    ./lf.nix
    ./nix.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./lua.nix
    ./notes.nix
    ./obs.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./video.nix
    ./vim.nix
    ./waybar.nix
  ];
  home = {
    username = "chrisaddy";
    homeDirectory = "/home/chrisaddy";
    stateVersion = "23.11";
    packages = with pkgs; [
      dust
    ];
  };

  programs.home-manager.enable = true;
  programs.ripgrep.enable = true;

  nix = {
    gc = {
      automatic = true;
      frequency = "daily";
    };
  };
}
