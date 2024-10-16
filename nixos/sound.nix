{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mpd
  ];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = false;
    wireplumber.enable = true;
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.chrisaddy.uid}";
  };
}
