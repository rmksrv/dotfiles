{ nixpkgs, ... }: 

{
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";

  imports = [
    ./packages.nix
  ];
}
