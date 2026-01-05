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
          ./darwin/default.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            users.users.rmksrv = {
              name = "rmksrv";
              home = "/Users/rmksrv";
            };
            home-manager.users.rmksrv = import ./home/default.nix;
          }
        ];

      };
    };
  };
}
