{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    kanata
  ];

  # Create systemd user service for Kanata
  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Environment = "PATH=/run/current-system/sw/bin";
      ExecStart = "${pkgs.kanata}/bin/kanata --config %h/.config/kanata/config.kbd";
      Restart = "always";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  # Ensure the config directory exists
  home.file.".config/kanata" = {
    recursive = true;
    ensure = "directory";
  };

  # Basic example kanata configuration
  home.file.".config/kanata/config.kbd".text = ''
    (defsrc
      esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      caps a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      lctl lmet lalt           spc            ralt rmet rctl
    )

    (deflayer base
      @esc 1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
      @cap a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft z    x    c    v    b    n    m    ,    .    /    rsft
      lctl lmet lalt           spc            ralt rmet rctl
    )

    (defalias
      esc (tap-hold 200 200 esc lctl)  ;; Escape when tapped, Control when held
      cap (tap-hold 200 200 caps lctl)  ;; Caps when tapped, Control when held
    )
  '';
};
}
