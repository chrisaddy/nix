{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, emacs-overlay, nixvim }:
  let
    pkgs = import nixpkgs {
      overlays = [self.inputs.emacs-overlay];
    };
    configuration = { pkgs, ... }: {
      environment.systemPackages =
        [ pkgs.vim
        ];

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.chrisaddy = {
    name = "chrisaddy";
    home = "/Users/chrisaddy";
  };
    };
  in
  {
    # $ darwin-rebuild build --flake .#io
    darwinConfigurations."io" = nix-darwin.lib.darwinSystem {
      modules = [ 
       configuration 
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.chrisaddy = {...}: {
              imports = [
                ./home.nix
                nixvim.homeManagerModules.nixvim
              ];
            };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."io".pkgs;
  };
}
