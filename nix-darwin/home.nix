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
    # ../nixos/home-manager/books.nix
    #../nixos/home-manager/browser.nix
    # ../nixos/home-manager/c.nix
    # ../nixos/home-manager/discord.nix
    # ./emacs.nix
    #../nixos/home-manager/email.nix
    ../nixos/home-manager/git.nix
    ./keyboard.nix
    #../nixos/home-manager/go.nix
    # ../nixos/home-manager/k8s.nix
    ./nix.nix
    #../nixos/home-manager/lua.nix
    #../nixos/home-manager/notes.nix
    #../nixos/home-manager/python.nix
    ../nixos/home-manager/shell.nix
    #../nixos/home-manager/sound.nix
    ./terminal.nix
    #../nixos/home-manager/video.nix
    ../nixos/home-manager/vim.nix
  ];
  home = {
    username = user.name;
    homeDirectory = "/Users/${user.name}";
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
