{
  description = "hyperprior command center";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    emacs-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [self.inputs.emacs-overlay];
    };
  in {
    nixosConfigurations = {
      aion = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.chrisaddy = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
