{config, pkgs, inputs, ...}:

{
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services.tailscale.enable = true;
  services.openssh.enable = true;
  users.users.chrisaddy.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMv2Rv0k3HjzMsispSYCSTnrR1mz76QaQ+0WDCco/0e"
  ];


  networking = {
    hostName = "aion";
    networkmanager.enable = true;
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    firewall = {
      allowedTCPPorts = [
        22   # ssh
        8265 # ray cluster dashboard
      ];
    };
  };
}
