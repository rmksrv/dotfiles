{ pkgs, ... }:

{
  imports = [
    ../../wezterm.nix
  ];
  home.stateVersion = "25.11";
}
