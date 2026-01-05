{
  description = "darwin system flake";

  inputs = {
    nixpkgs = { 
      url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations = {
      "Romans-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          {
            system.stateVersion = 6;
            nixpkgs.hostPlatform = "aarch64-darwin";
            nix.settings.experimental-features = "nix-command flakes";
          }
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.users.rmksrv = ./home.nix;
          }
        ];
      };
    };
  };
}
