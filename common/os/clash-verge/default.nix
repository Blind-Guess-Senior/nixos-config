{ lib, pkgs, ... }:

{
  programs.clash-verge = builtins.mapAttrs (_option: value: lib.mkDefault value) {
    enable = true;
    package = pkgs.clash-verge-rev;

    serviceMode = true;
    tunMode = true;
  };
}
