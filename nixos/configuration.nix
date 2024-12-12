{
  self,
  config,
  pkgs,
  callPackage,
  ...
}: {
  imports = [
    ./hardware-configuration/aion.nix
    ./docker.nix
    ./networking.nix
    ./peripherals.nix
    ./sound.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
                    ${pkgs.greetd.tuigreet}/bin/tuigreet \
               --time \
               --asterisks \
        --remember \
               --user-menu \
        --cmd sway
      '';
    };
  };

  services.printing.enable = false;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  security = {
    sudo.extraRules = [
      {
        users = ["chrisaddy"];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
    polkit = {
      enable = true;
    };
  };

  programs.zsh.enable = true;

  users.users = {
    chrisaddy = {
      isNormalUser = true;
      description = "chrisaddy";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
      ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    shells = [pkgs.zsh];
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XCURSOR_SIZE = "24";

      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
      QT_QPA_PLATFORM = "wayland";
      QT_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      vim
      wget
      unzip
      obs-studio
      wlr-randr
      xdg-desktop-portal-wlr
      xwaylandvideobridge
      isync
      mu
      pinentry-curses
      google-chrome
      nyxt
    ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "chrisaddy";
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    # flake = "home/chrisaddy/.config/nixos";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-emoji
    fira-code-symbols
    # nerdfonts
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root chrisaddy
    '';
    settings = {
      extra-substituters = ["https://devenv.cachix.org"];
      extra-trusted-public-keys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
    };
  };
  system.stateVersion = "24.05";
}
