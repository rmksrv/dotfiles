{ pkgs, ... }:

{
  imports = [
    ./wezterm.nix
  ];

  home = {
    homeDirectory = "/Users/rmksrv";
    stateVersion = "25.11";
  };
}
