{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./window-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    neovim
    ghostty
  ];

  environment.variables = {
    PATH = "$PATH:$HOME/.cargo/bin";
  };

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  system = {
    configurationRevision = null;
    stateVersion = 5;
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;
    };
  };

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  users.users.chrisaddy = {
    name = "chrisaddy";
    home = "/Users/chrisaddy";
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
