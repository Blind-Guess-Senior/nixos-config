{ lib, pkgs, ... }:

{
  services.displayManager = {
    sessionPackages = [ pkgs.niri ];

    defaultSession = lib.mkForce "niri";
  };
}
