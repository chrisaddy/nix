{
  description = "Darwin system flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    emacs-overlay,
    nixvim,
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        emacs-overlay.overlay
        (final: prev: {
          stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    };
  in {
    darwinConfigurations."io" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./configuration.nix
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
      specialArgs = {inherit inputs pkgs;};
    };

    darwinPackages = self.darwinConfigurations."io".pkgs;
  };
}
