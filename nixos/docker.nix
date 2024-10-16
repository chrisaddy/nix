{config, pkgs, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    extraOptions = "--iptables=true --ip-masq=true";
    # if bridge IP conflicts:
    # extraOptions += "--bip=192.168.1.1/24";
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPorts = [
        6783
        6784
      ];
    };
  };
}
