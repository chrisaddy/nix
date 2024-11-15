{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.neovim
    pkgs.kanata
  ];

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

  users.users.chrisaddy = {
    name = "chrisaddy";
    home = "/Users/chrisaddy";
  };

  # Kanata configuration
  launchd.agents.kanata = {
    serviceConfig = {
      Label = "com.kanata.agent";
      ProgramArguments = [
        "${pkgs.kanata}/bin/kanata"
        "--config"
        "/Users/chrisaddy/.config/kanata/config.kbd"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/Users/chrisaddy/.config/kanata/kanata.log";
      StandardErrorPath = "/Users/chrisaddy/.config/kanata/kanata.error.log";
      # Ensure kanata can access input devices
      Nice = -20;
    };
  };
}
